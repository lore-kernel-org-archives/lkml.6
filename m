Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELufHIRlwPBWdmRcPrZdTFt7I6jWrVfX6Ovznj6VdW4dsQHtVw3Y2hqrKIDQW56MgmMxgHSv
ARC-Seal: i=1; a=rsa-sha256; t=1520641243; cv=none;
        d=google.com; s=arc-20160816;
        b=XC15/3FWJcV8ODIyyGurYtwRF+Vl6deMsvrEq/EPtG6Kvlco5PYA5ZPBClJeiflYWr
         MH9t3B5mRuf3XInSfj01efJejsqsEJh1o8r+34iDc+IR+urxny+dmqM8u4scAeuoQDRs
         arK6tpIuLWUzH+uY522xW/E4ExNDqBPRXF9WZ3pbU2LuwYnQvATYxSVlg3ysSPXQcmLo
         TTd8lv2BGrT052+0kHbDHOnq7LUu9d0yio+hKdaU9D4Kz/pEvv05F5/1EDcmRL19P4oH
         xpN86uPiPm1YGrLSkQUtd7InyxFGyE1PolOsSjaj1YVoS4HZTdRmPyWEZxHZyWFQu6tC
         rMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ax5rvJBAMO+6WqJW2U7Uc9pw94Q+p+d1Pp5pQ/dpcy8=;
        b=RAb7cS912ORdvOLGg25eA6Ph7rc/pNvEtJHbfzggSQGUXIp5fxfVXSWXgoWADzS9NS
         qsJ3GsLS+FNKclqtZzBT9Py1ORdzO8SnDzY8jECnEz5TJ7XTUN9aws93+nJWuTPy1B3I
         yk9xb4dOiI24DUl2HCTVICuHOjdodFs6HI7Apt+8NgfZzGDZTuTTAGH2IgwtIb0JcCZM
         nO/QHBlDNLAQMU/VlkOFjCeGcvAQG1AJ+vbLuIMFmBwqV9AmVjU1Eb76IiwuG/PM8F8m
         8B54BZwhV2gqqGntpl0zyq3kcHJKaeS0JRoPH30jU76YIOErl9TQLhPg+VY+YLNN+3EO
         JixA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 28/36] sctp: fix dst refcnt leak in sctp_v6_get_dst()
Date: Fri,  9 Mar 2018 16:18:44 -0800
Message-Id: <20180310001808.915272334@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507824174857982?=
X-GMAIL-MSGID: =?utf-8?q?1594507912206606873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 957d761cf91cdbb175ad7d8f5472336a4d54dbf2 ]

When going through the bind address list in sctp_v6_get_dst() and
the previously found address is better ('matchlen > bmatchlen'),
the code continues to the next iteration without releasing currently
held destination.

Fix it by releasing 'bdst' before continue to the next iteration, and
instead of introducing one more '!IS_ERR(bdst)' check for dst_release(),
move the already existed one right after ip6_dst_lookup_flow(), i.e. we
shouldn't proceed further if we get an error for the route lookup.

Fixes: dbc2b5e9a09e ("sctp: fix src address selection if using secondary addresses for ipv6")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -323,8 +323,10 @@ static void sctp_v6_get_dst(struct sctp_
 		final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &final);
 		bdst = ip6_dst_lookup_flow(sk, fl6, final_p);
 
-		if (!IS_ERR(bdst) &&
-		    ipv6_chk_addr(dev_net(bdst->dev),
+		if (IS_ERR(bdst))
+			continue;
+
+		if (ipv6_chk_addr(dev_net(bdst->dev),
 				  &laddr->a.v6.sin6_addr, bdst->dev, 1)) {
 			if (!IS_ERR_OR_NULL(dst))
 				dst_release(dst);
@@ -333,8 +335,10 @@ static void sctp_v6_get_dst(struct sctp_
 		}
 
 		bmatchlen = sctp_v6_addr_match_len(daddr, &laddr->a);
-		if (matchlen > bmatchlen)
+		if (matchlen > bmatchlen) {
+			dst_release(bdst);
 			continue;
+		}
 
 		if (!IS_ERR_OR_NULL(dst))
 			dst_release(dst);
