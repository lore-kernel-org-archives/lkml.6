Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48c4FLZbbZTU7FaDzpniZvcjBB51hWTZ1f6cN9VIGrbOcTpIhSqPX+kBOSAVd9UG/+nWxAQ
ARC-Seal: i=1; a=rsa-sha256; t=1524406737; cv=none;
        d=google.com; s=arc-20160816;
        b=aL4hANLZ1XszaSrUXvi3C1f1Bw6sdotKNA2aMTW2n17H5kax5dUWT40hamUuUGebDA
         LRt/0ajfujfRjUakied80WiEX60G4bYdihq1TyMnfoqub5MLEXSoKqZtySpZUlV6DnnE
         C0gVjU6/RSQkBVFWLV29TW/+PK/VrI2kFePVXVf6j7kSLnPfHZjnRN6r9ykBHFghjgyC
         a/Rh8UENGzLmNzmLj4REaPW5YFi1sNecn3+SsTOX01H/QGbedlq9SCEpfP5zz/irSUKu
         ynVwJeLZ3qjimiTDjFSeGJWn2jfMSek/GxG3lNlHDOVOvcpzGAw3Z026L3tEChcZxjWs
         UNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XQGUV30mWhGlzQRHnhmdsOpo5TZuyxucWgwd4s8/RfI=;
        b=H++W2VbjmW/nSiQkxHMqKVB8Sx6+aAQd4pfI/qDGGAY+0xzvSd8LNjzVzgPA9wgbRu
         p/FPrlu5e5+K+kYjhEVmETTpbNlAonXWHqj8KoqaU5zEnWpa3NHIHKRzGPjFl95l/Ljb
         OULK0/v9ebjfQcBsLpcRIZXKCuK34ukeo6bh5sHuWjm4G0REgg0UV9up4BetPUDC1jDt
         a2tLbsR6E9EBSSSFbxeB5b/P5sRNYmkvMziXjBMj0AqX56erNnHVsni6GWZs0AW+dRqY
         +voxstoRCCyIDzO2TNgjIOw1Nk5ReS/ZL/6sTCkeYB8gSudYnLNlh1Mx+HvTGN1P4iyj
         +s5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>,
	Michael Neuling <mikey@neuling.org>,
	Russell Currey <ruscur@russell.cc>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 86/97] powerpc/eeh: Fix enabling bridge MMIO windows
Date: Sun, 22 Apr 2018 15:54:04 +0200
Message-Id: <20180422135309.888967753@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455273756324131?=
X-GMAIL-MSGID: =?utf-8?q?1598456319605735999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit 13a83eac373c49c0a081cbcd137e79210fe78acd upstream.

On boot we save the configuration space of PCIe bridges. We do this so
when we get an EEH event and everything gets reset that we can restore
them.

Unfortunately we save this state before we've enabled the MMIO space
on the bridges. Hence if we have to reset the bridge when we come back
MMIO is not enabled and we end up taking an PE freeze when the driver
starts accessing again.

This patch forces the memory/MMIO and bus mastering on when restoring
bridges on EEH. Ideally we'd do this correctly by saving the
configuration space writes later, but that will have to come later in
a larger EEH rewrite. For now we have this simple fix.

The original bug can be triggered on a boston machine by doing:
  echo 0x8000000000000000 > /sys/kernel/debug/powerpc/PCI0001/err_injct_outbound
On boston, this PHB has a PCIe switch on it.  Without this patch,
you'll see two EEH events, 1 expected and 1 the failure we are fixing
here. The second EEH event causes the anything under the PHB to
disappear (i.e. the i40e eth).

With this patch, only 1 EEH event occurs and devices properly recover.

Fixes: 652defed4875 ("powerpc/eeh: Check PCIe link after reset")
Cc: stable@vger.kernel.org # v3.11+
Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/eeh_pe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -788,7 +788,8 @@ static void eeh_restore_bridge_bars(stru
 	eeh_ops->write_config(pdn, 15*4, 4, edev->config_space[15]);
 
 	/* PCI Command: 0x4 */
-	eeh_ops->write_config(pdn, PCI_COMMAND, 4, edev->config_space[1]);
+	eeh_ops->write_config(pdn, PCI_COMMAND, 4, edev->config_space[1] |
+			      PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 
 	/* Check the PCIe link is ready */
 	eeh_bridge_check_link(edev);
