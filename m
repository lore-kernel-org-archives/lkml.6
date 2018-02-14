Return-Path: <garsilva@embeddedor.com>
X-Google-Smtp-Source: AH8x2276n6JFhF3GVbCP7w+FixSd21dp8vMJ8w+BHW+UrdFbGL4XNQH43icxq5HQ4wePptL8zU+G
ARC-Seal: i=1; a=rsa-sha256; t=1518629433; cv=none;
        d=google.com; s=arc-20160816;
        b=XzL6aoovhKBwK2OY1lERsyXYOTPg0JeXNFSisY67rENBEKT+VaNKStPouhznRHin9q
         r9roP89FErZ6CPpmp/tHZHw8/aqenIevt/jCnq5AhCm4dYk4E+84NT7v/vnVZ5IRBwsP
         HSkGnV06QptiMygH7/1hIj5vp6lQthX3sZonNQh+SvhRP+EQTjRI/RzgJFzKVnvJDLn1
         ZHwCUlhualYZiD+2AEnE2OA2oLJuC4gm46C448ZkjUIZNj/Kk6ENbuz/T3u1pNRLdHaV
         eg43g0ZfvsGcHN9yp4Soc8HJKTi/flHiHeIqKuBpSgId0X8GaJtfXvhtS0sSu+2Lgh2h
         Q6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=8uZ3OnaLriKEZ7AOKljYfMr+WcZu+RDYaht4l2KHeg0=;
        b=Hv1W/feDkRhZzK9cMIrPwWWpfFZ67b/izKu3B8qGjXdTpYFu98DX2ylF5VBlSgL0lX
         3CRaOIPIxeVciNuMTBUNxfbzaEXYeJYotV1qWde6+mz6yVAG7hwtq+k5sgIWhmfugmX0
         rv5750Zit+sWQyaQ0hqLOcqcItpa/OLdw36JT6F/ICqQgrKu7P/yV4OlzcCH5mkCGP7v
         KrOjnhT41YnlM+PespW26s3+9Z8EFgoA6eC0/B/br2pkH0CJZsVntfFkjPFu1aFxBrwE
         81mZib+dTQ1U2rbIXJHYyo/aMLjwZwPB3Np82FM+AjrBaNpYEuxqiBhJO8VybaUdVAbU
         8s/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of garsilva@embeddedor.com designates 192.185.143.4 as permitted sender) smtp.mailfrom=garsilva@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of garsilva@embeddedor.com designates 192.185.143.4 as permitted sender) smtp.mailfrom=garsilva@embeddedor.com
Date: Wed, 14 Feb 2018 11:30:29 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ipmi: kcs_bmc: mark expected switch fall-through in
 kcs_bmc_handle_data
Message-ID: <20180214173029.GA15661@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1em0t5-001MIe-5V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.4.238]:47000
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592398376863502226?=
X-GMAIL-MSGID: =?utf-8?q?1592398376863502226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1465255 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
This code was compiled with GCC 7.3.0

 drivers/char/ipmi/kcs_bmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 3a3498a..6476bfb 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -95,6 +95,7 @@ static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
 	switch (kcs_bmc->phase) {
 	case KCS_PHASE_WRITE_START:
 		kcs_bmc->phase = KCS_PHASE_WRITE_DATA;
+		/* fall through */
 
 	case KCS_PHASE_WRITE_DATA:
 		if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
-- 
2.7.4
