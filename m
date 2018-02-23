Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvjrIR/oMCm3WcuzFK4IpYWX2oxCK54tt3mBvVAizhmXTgwJBAdnFS/DNVpcgFitGTleoLv
ARC-Seal: i=1; a=rsa-sha256; t=1519412039; cv=none;
        d=google.com; s=arc-20160816;
        b=Oq2T6kE+HJK3w9tPOQ82BdUI/HuHZLWYWpwo6FNvq5tcUsuVrXPA/uNRUC9a76hp/4
         Sey4P7jkfc1clks4FUsWFYIM7/HR3ak9VJTRPX6CVrmt86kVspsdccQ3B7p0NAv6rWOT
         UCoPre38ib+zWlWDnMBSC1rrXopX099hxCFxiv5/7jAOkKnGlun92GZPWluBSZsHfcTg
         brcEFrjGCWd7fdSSzF5O1gZWAlSgfaTjt+/yjoqvitirP24+RXbh7ohd7CFc7bEP3e+h
         J51XZ2g6581lgurknU/Ndr2TSIBD3tl02GhJcLiOIDAovxs/8XuKNXrwky45RZGaS3f0
         dNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gvGwDXZjs70dEy86e/9WmSjQtlBjYFNpPo3HcDUdf+U=;
        b=Ky/ued1OIk94Q6wQOzVkTRXuDKSEWo57BuJA2jlXySHRm9NUY/AEHj03JLQhX6BKKf
         z2FY4JBofDe2EGOEP+JUrEzHLbmTZbOYuiZa/4XKkqV7qtiUnncIJWuiCPK+h2m2iTio
         krjYl3kWj766OBFnEmT3qLGDIPRaPJqzSFkSnvXT0a00l6rav0JjgW6kHOJJfQ19/pMx
         iipp+llBJpiySkJaLUEgtiz6LZvmyqEuZgTPTQgkqeyHu+b6TvWwPYIJ1QQ/cXan/Aiq
         /sKJMIKwuML9CJRTe0UwDtK2MUyeS95jAlUruSndOMP7p46paPM7u9q6ShnTR6yExzZ0
         hE4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 102/159] bnxt_en: Need to unconditionally shut down RoCE in bnxt_shutdown
Date: Fri, 23 Feb 2018 19:26:50 +0100
Message-Id: <20180223170755.775602161@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218998410584422?=
X-GMAIL-MSGID: =?utf-8?q?1593218998410584422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ray Jui <ray.jui@broadcom.com>


[ Upstream commit a7f3f939dd7d8398acebecd1ceb2e9e7ffbe91d2 ]

The current 'bnxt_shutdown' implementation only invokes
'bnxt_ulp_shutdown' to shut down RoCE in the case when the system is in
the path of power off (SYSTEM_POWER_OFF). While this may work in most
cases, it does not work in the smart NIC case, when Linux 'reboot'
command is initiated from the Linux that runs on the ARM cores of the
NIC card. In this particular case, Linux 'reboot' results in a system
'L3' level reset where the entire ARM and associated subsystems are
being reset, but at the same time, Nitro core is being kept in sane state
(to allow external PCIe connected servers to continue to work). Without
properly shutting down RoCE and freeing all associated resources, it
results in the ARM core to hang immediately after the 'reboot'

By always invoking 'bnxt_ulp_shutdown' in 'bnxt_shutdown', it fixes the
above issue

Fixes: 0efd2fc65c92 ("bnxt_en: Add a callback to inform RDMA driver during PCI shutdown.")

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8218,8 +8218,9 @@ static void bnxt_shutdown(struct pci_dev
 	if (netif_running(dev))
 		dev_close(dev);
 
+	bnxt_ulp_shutdown(bp);
+
 	if (system_state == SYSTEM_POWER_OFF) {
-		bnxt_ulp_shutdown(bp);
 		bnxt_clear_int_mode(bp);
 		pci_wake_from_d3(pdev, bp->wol);
 		pci_set_power_state(pdev, PCI_D3hot);
