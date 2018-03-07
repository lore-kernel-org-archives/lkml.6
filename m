Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELurAxO8kwh5JM96jXk3291qzKULQCU/GdnKYiXwm7WZDzPisLtML2Az/fGzEsnUd4Cs56bY
ARC-Seal: i=1; a=rsa-sha256; t=1520451781; cv=none;
        d=google.com; s=arc-20160816;
        b=AsYtxKzoc+UVh7EPj/x0a71ZmvP8QsGR8h2IWLhXx41z+Vi4KyJNRhScbVoVmjJ/pb
         T5rCNjlECrCg0OtuIdBUk/3T8LeUANnQ4y3R9jbu5mzkNEnFCsWB3cHBkgWI8IcdgRjm
         vnrPpc6+/SwrHg1IoyP+M8tot+hsaeYs/AjCygiXxwmk5j2DfMg3OU2GvmRD6ee0UW0l
         cVSQn7E0lHragbfq8g5oCmuJa28NauKF+8iebavyXtpjMZySjhj15xVMOod5iYpVYEJN
         241MVh3xuZTz1yRpLX6uBjpUHdT66pVrM7r4He4D4wW8TfNhnWEWRwBmsBduShNSoGG6
         s5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=97ISj28BoXAcD8kb0qFfooGmQmWdtCpDRTyMuOeZRCk=;
        b=gWhMxBeZh9rppe8V0JSARBHWZLHrlc8fnGgKd2VhFEHED7RkCJu50sn3l1L4Be1FIj
         TOh6HGmWJe9NcvhJuUL6oDhBQO9p3ZMV1x6wGw2XWUkw+F6wjcunqhZAwkJpnzYkkDFH
         KAi4ZF0iS02JxMJOwuJcaaprHK9pXBkBY8NoCx4t9/aEFkOh0meNvrJEXqjdiz7Xswp7
         mKvc4hxi5vUB/CfWpEOedJQlM2aAzLBZwK3cjEneXjj1ARlbUlNssJ8ulM703DsifzTy
         tdGyeUdsGvQNj77MGM/1eQ2VHba5vuhMm7fOMa/10t/JvxCNax3nHlVl0UBlSvrgIjPt
         QqKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 092/122] s390/qeth: fix double-free on IP add/remove race
Date: Wed,  7 Mar 2018 11:38:24 -0800
Message-Id: <20180307191742.671669621@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309247327891075?=
X-GMAIL-MSGID: =?utf-8?q?1594309247327891075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 14d066c3531a87f727968cacd85bd95c75f59843 ]

Registering an IPv4 address with the HW takes quite a while, so we
temporarily drop the ip_htable lock. Any concurrent add/remove of the
same IP adjusts the IP's use count, and (on remove) is then blocked by
addr->in_progress.
After the register call has completed, we check the use count for
concurrently attempted add/remove calls - and possibly straight-away
deregister the IP again. This happens via l3_delete_ip(), which
1) looks up the queried IP in the htable (getting a reference to the
   *same* queried object),
2) deregisters the IP from the HW, and
3) frees the IP object.

The caller in l3_add_ip() then does a second free on the same object.

For this case, skip all the extra checks and lookups in l3_delete_ip()
and just deregister & free the IP object ourselves.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l3_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -320,7 +320,8 @@ int qeth_l3_add_ip(struct qeth_card *car
 				(rc == IPA_RC_LAN_OFFLINE)) {
 			addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			if (addr->ref_counter < 1) {
-				qeth_l3_delete_ip(card, addr);
+				qeth_l3_deregister_addr_entry(card, addr);
+				hash_del(&addr->hnode);
 				kfree(addr);
 			}
 		} else {
