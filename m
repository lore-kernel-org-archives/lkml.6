Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/UCDWJJl7urkKMwYXI82xSkmLeaqxEj+9XTaNFYjmk772OkcG7v9fGIwoSHvtMVChjRgDL
ARC-Seal: i=1; a=rsa-sha256; t=1524406470; cv=none;
        d=google.com; s=arc-20160816;
        b=ptQ9CEPpVbqietz2e09RUtG8GyB6y4Rff3q99m9v9n09emeLm0aUsnproWGWUEWmTR
         b+HIPxvElxm/MrDZYGHfUCZYfACw+24v0fjVHthssNpSJt6dU+ONI5wXWZPanxB43lJT
         zrZSMHGnoFEi96Uhgumf4YZQJ2DoN1TprzQw+WohEo9RNN6QoeekfymOxnJ6saT/kvIc
         GufG8TZ+AbZsnserjtRawWzu89h8VYSJlF4pyYY+NtYZpZtPBn3QBEO/5Sw0cRsscLTZ
         y7hScZO0NxgTfbJAM5dpwziPQHLRo/1QaWcJCGgvcNIJMvfNXqEYg6jCVvZPNayDk8J6
         9Y/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+ktORAUJD4TwgaA8UxKq4T+d/Os065gv5Q8cISQwI64=;
        b=vj7rUR3GlWzoqQTMH4t2r+jspuoZsxcKtOKNp5TDcEg+b7euHw9OQsoAtkufr2/c+3
         aGnYGz1iGNKhcfr88YzoKIBQgjLZqSunE9Zio0Z53YH04XL7VoIp2IeHZG/ZVXV8JZsH
         JQbsuuTm5A7/y6QmXEpAdImP/gi4KZENwN/fUkiAjUnr1ksivfdl/1sIq8N+tVzH1kYI
         dgB2GEs1A4/F48UgeT4YNU4/XRqtupNkGAfe70mEVfpjMkkhMg81sww3U/xcJIrrmBHl
         0/T0e7T2Lx7QFHBs/nyGbCZIuB39ALqfQRTALEAeL0snNV3YfLdAgETd8xxh6iWEVMn9
         Bbbw==
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
Subject: [PATCH 4.9 83/95] powerpc/eeh: Fix enabling bridge MMIO windows
Date: Sun, 22 Apr 2018 15:53:52 +0200
Message-Id: <20180422135213.820559868@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455273756324131?=
X-GMAIL-MSGID: =?utf-8?q?1598456039581949859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -795,7 +795,8 @@ static void eeh_restore_bridge_bars(stru
 	eeh_ops->write_config(pdn, 15*4, 4, edev->config_space[15]);
 
 	/* PCI Command: 0x4 */
-	eeh_ops->write_config(pdn, PCI_COMMAND, 4, edev->config_space[1]);
+	eeh_ops->write_config(pdn, PCI_COMMAND, 4, edev->config_space[1] |
+			      PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 
 	/* Check the PCIe link is ready */
 	eeh_bridge_check_link(edev);
