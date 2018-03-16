Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvi/3Ox8iq/rcqsIbhrbsrIuN9DwMN77PPITiOlexMbJoIsQtj48Ms4xdC5HIP6xoZJs4+Y
ARC-Seal: i=1; a=rsa-sha256; t=1521214997; cv=none;
        d=google.com; s=arc-20160816;
        b=jZDtv9wxG2jL28JOze+wtC+0GvdgliPcIMCtExDNLoudZMfTqkoinn0hGmVpaTkOHs
         DeNlqV1KpmK5Yz4XWu3IdzF1l7p1wRB40xQ+cJmtaA3OZMPbteauYmZmloA+E2jP0NdJ
         G26M4BR4+XHOwDYeSrVdcDrJMcLDTZWO62GOHOh7G07BTyhpvFqGUmib02eK7nK1SE4N
         vtPkE8lK3Y5/jRuXKP02OuM5rzwEkqoVSVm5qLWWsUDabjHwDcoB9V3JOc1VY7wmlwVv
         HKXjp/noLft8X/EZXehDnSBR6AayIC/QcecIRRK9psthhMaa4pQPM1olMZ9yiRLMjIoH
         qqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uYP7Hw7RphgTe5vWvcVu5fzrb8puPvdX1j6Gupv1Ugo=;
        b=Dn78VwMhZSXMKtDg3ygGc5Le1CS/N/kjHhRH3wx7+M3POhGheci9dfrk3Fvfqm+aUh
         lBPq4Y5BpYO79ao/jWPgb3Wt73qwMbXvtmfqTbVy3Al7hDvi5aNxi4qPLaWArHiO4CYh
         1HLicjWSWpUTFHGBJ5A1Uh+Bn/ba3zSaebJHsYdV9Crl3FqKsufmLNkXJsyEf5agOACc
         N6QA42JM8mn5RQ/4KVdME5Ylp8DyPrTxn28x8IPSz76IEJOS4ZRYlHXqow4GUwuvUWVY
         fB19kYH9zhSpSoEWVexhEZLwzHoFWJW9nBlIQFaNW77xCJJWreV2HEkuo3sPm0qUvILz
         05sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 092/128] bnxt_en: Uninitialized variable in bnxt_tc_parse_actions()
Date: Fri, 16 Mar 2018 16:23:53 +0100
Message-Id: <20180316152341.132311918@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109536783199250?=
X-GMAIL-MSGID: =?utf-8?q?1595109536783199250?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 92425c40676d498efccae6fecdb8f8e4dcf7e4a4 ]

Smatch warns that:

    drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c:160 bnxt_tc_parse_actions()
    error: uninitialized symbol 'rc'.

"rc" is either uninitialized or set to zero here so we can just remove
the check.

Fixes: 8c95f773b4a3 ("bnxt_en: add support for Flower based vxlan encap/decap offload")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -148,9 +148,6 @@ static int bnxt_tc_parse_actions(struct
 		}
 	}
 
-	if (rc)
-		return rc;
-
 	if (actions->flags & BNXT_TC_ACTION_FLAG_FWD) {
 		if (actions->flags & BNXT_TC_ACTION_FLAG_TUNNEL_ENCAP) {
 			/* dst_fid is PF's fid */
@@ -164,7 +161,7 @@ static int bnxt_tc_parse_actions(struct
 		}
 	}
 
-	return rc;
+	return 0;
 }
 
 #define GET_KEY(flow_cmd, key_type)					\
