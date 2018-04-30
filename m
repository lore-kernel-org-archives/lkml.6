Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AB8JxZobpgE/EjcTejDBxnTDiYDIvveAT76/KLF78lhGOPgf2tWtyQtZtfKx80RvxM/Wi3V2VdGp
ARC-Seal: i=1; a=rsa-sha256; t=1525092643; cv=none;
        d=google.com; s=arc-20160816;
        b=Ya9kwwCJBEmcy5G/dh5vz+o3/wZmUyDe+L/Qy+gzCtKr9BAJ75ahHhNvvFa3CGAvDR
         1i7KT9H4F4pVP9mqreWILOONpC53ENFUK2/YTqs4p+AAe8FtraRfEWwQrgueY4GkdsPJ
         5x/Gswipu5EeOipre1Xdkx4vdODp4ONM1x1tdVf59L7BubKXQCNGVJqukFaLpNtHuhu1
         k/0fJHMSsoW4d52zYg9ttkenC0trr/zzzn9+cCuFlDNS9f26H+w63OXcOgqpJHVe/4Ou
         b1mP7kzqxLF1p530bUXvGTI+W7V19EH2WipPfUbEKymsSerBHXQJ7AhtKY/oKZNhrI2v
         b2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=BqR7QfhY6Mi4oupWnnwUnQ/yLumBQc8B9UgagWBb+dA=;
        b=BT50tiMjDvk7Cium7raINGcTnVKtF8UVOL6pGarSLBFBuhpcca2raPi42NGa2q2Hte
         osSpEtJ9id6MDuNmmiTC31Bpzr3OXP/IIRkXqtv0R74ljh3TKhIqm4W5+8//dL0O1bns
         yEsrGfL6AcnSMQHCsXR6YW98PtHRvL5hqzcz80shVq4updru6dOD62S3sXkkO4LoBOmT
         ga7FxikWN5v87LXV/upo1QljLsmuiUW6U8bJZ7UiSVNK+ccd+kOeDvPOuP3aTTcSZhym
         CFTKM0/ePDnl9XP72uPRHVy5+BafrjL9/WDr53ZyajxII5eypaxtLXYCKZ3eUdEfc0BO
         JmlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.193.119 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.193.119 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Date: Mon, 30 Apr 2018 07:50:40 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Ganesh Krishna <ganesh.krishna@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] staging: wilc1000: fix infinite loop and out-of-bounds access
Message-ID: <20180430125040.GA19050@embeddedor.com>
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
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fD8GQ-001tA1-NB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.172.56.86]:60019
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599175544219202800?=
X-GMAIL-MSGID: =?utf-8?q?1599175544219202800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If i < slot_id is initially true then it will remain true. Also,
as i is being decremented it will end up accessing memory out of
bounds.

Fix this by incrementing *i* instead of decrementing it.

Addresses-Coverity-ID: 1468454 ("Infinite loop")
Fixes: faa657641081 ("staging: wilc1000: refactor scan() to free kmalloc memory on failure cases")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>
---

BTW... at first sight it seems to me that variables slot_id
and i should be of type unsigned instead of signed.

 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index 3ca0c97..67104e8 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -608,7 +608,7 @@ wilc_wfi_cfg_alloc_fill_ssid(struct cfg80211_scan_request *request,
 
 out_free:
 
-	for (i = 0; i < slot_id ; i--)
+	for (i = 0; i < slot_id; i++)
 		kfree(ntwk->net_info[i].ssid);
 
 	kfree(ntwk->net_info);
-- 
2.7.4
