Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqNOw86VBbZDS5Ywwz9lbGS2eMehNwJgsrlHM+1nPNn9h0cRqxkI2HOUpHQGKE1DviLIj/4
ARC-Seal: i=1; a=rsa-sha256; t=1524837992; cv=none;
        d=google.com; s=arc-20160816;
        b=mvDw8D3NETX8CilIq0x9zWLAGOzy5y4RQY++xMKdCCOe64Q/n/x+mDmPN+HkddP7rX
         5JpmCmbgPfrzYtK8sgLsDzQwatqGlamxCfG8V2eUlt9vgV3/DHKRBlE9f3MwlHDgN5ub
         ld/FPw7Al7DgKpFd0owUPZl97KOfNoewgkl7CxHbRKiZVkfxud5V5YRE9QboNi79B+Ty
         lZ/OzutDQwCLwC2zRjalLsQ1XLc0Zc+TbHfd/vH5KB8gvugOSw2osy26jogDR3jKn64w
         z60+OV+8TNzeyZhaI6SGXAU5SWcO4vagKTykrb3G8yvDdILIYkT3rt5QtAtRNno7IyaK
         OjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=xnKfPoBUUxFNIr15mKFuKUCV1I6uYSrl7Wz6M2LVuq0=;
        b=GFpCRENzDmSHElKHyr20SZXJ/PvMFg86BdggRRcV0qR1XjAp0hiyZ9tRQ71hGvh+TV
         Vz4TlLmuKAzs1LXG+NG4QhSCFZ3ZTqhf64wu8wYkCMS0ZYnDewNYSvWhNITaskOFvKLH
         qLY1CkiWZ5WjIP/Mfs0I8eSFFZL0IGifPSAVhEqcEISpgiLZ4NYJodWOgyf7McWa55Pe
         uc6sC0UwGnaAQ/cGJekLYZ62a8rJPwt9pjV1g6ooOUToPMP0AUuowOmtvKDIBVDNHQlc
         WGjb4caYNfuXkIsSO3sJx9NVjH2Ehbk0kP+wcXoXQzx3a8dIMLhBFKXHx3+LErEX6L2L
         OApA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E37221890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 20/80] net/smc: fix shutdown in state SMC_LISTEN
Date: Fri, 27 Apr 2018 15:58:13 +0200
Message-Id: <20180427135733.945798926@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908523197480911?=
X-GMAIL-MSGID: =?utf-8?q?1598908523197480911?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ursula Braun <ubraun@linux.vnet.ibm.com>


[ Upstream commit 1255fcb2a655f05e02f3a74675a6d6525f187afd ]

Calling shutdown with SHUT_RD and SHUT_RDWR for a listening SMC socket
crashes, because
   commit 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
releases the internal clcsock in smc_close_active() and sets smc->clcsock
to NULL.
For SHUT_RD the smc_close_active() call is removed.
For SHUT_RDWR the kernel_sock_shutdown() call is omitted, since the
clcsock is already released.

Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1203,14 +1203,12 @@ static int smc_shutdown(struct socket *s
 		rc = smc_close_shutdown_write(smc);
 		break;
 	case SHUT_RD:
-		if (sk->sk_state == SMC_LISTEN)
-			rc = smc_close_active(smc);
-		else
-			rc = 0;
-			/* nothing more to do because peer is not involved */
+		rc = 0;
+		/* nothing more to do because peer is not involved */
 		break;
 	}
-	rc1 = kernel_sock_shutdown(smc->clcsock, how);
+	if (smc->clcsock)
+		rc1 = kernel_sock_shutdown(smc->clcsock, how);
 	/* map sock_shutdown_cmd constants to sk_shutdown value range */
 	sk->sk_shutdown |= how + 1;
 
