Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48uetOKgwTlY4ZrKAq029QNEStbS5FcKMDen/BuvtsgdCPFpvlKYaMTzY062fo5RkJIE9y6
ARC-Seal: i=1; a=rsa-sha256; t=1523473310; cv=none;
        d=google.com; s=arc-20160816;
        b=vly4wNOXEeEl3eHINKLGxK8xqShFaDT3ErDDnpc3b5Se6VfFOvltsXGWaKbAd3B+ul
         +wWsaJ+T/jOkPmKi2cTEZGjhRRdo3FnBWNjyAhIjpwBZHCkKSkWswG+04J0eHnzfxzyn
         3nEQw8gFw9BJ2UewmK/c2WggHXhKNWA9t6trHrZdsqcIdN+H6cMDwbbYS8d2rWgTCR3l
         KhRFL8e/Gv3/do1SmW5FP3/dYYIYzvBuQtpfysYPKm9hg2I9h70O/+DbG3w8F1JLhW8i
         Mzk47x1Xi6RmN68/ODMOk9Vv9L+8BIMSFz29JuCxMihbZBglPbEoceVybckNHDY3yzAE
         Cbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r0OxCOrA3jVfWKnGdhcSfa8Vu/tlWEANnlNwmThP6AE=;
        b=r6QDk7kTpBpHrPzxaK2MLEDufI4BWz+zUIFpfYXVWnz+8L0JCP1dtAS8K3wzS9qAxB
         QSUN3sSXxjNb3zqQyQr8hWj8rSwPPfrrx8NaQLiS2YY3oybWLDw7v3mJ0vVE1299VVCn
         dXz8rVEsK4+jUr4mLk7eMosuhOkZgBGQrFeyOKKBSgGa2u+D4lMw8DpEyqLZ67ttCeeS
         VCmDM5sljjwcPKEhyCgzDZv+NH+N85ey/bpNkh9hF7LMoiiRP7J77Y7rFmfolBlzcngg
         diymHcL5ILejyC1yL/lfvKh4exgT7YhxxnVB8TpDiXO+xxZz/qL48RoZL94LbVlNTOKd
         ZD/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Luca Coelho <luciano.coelho@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 201/310] iwlwifi: pcie: only use d0i3 in suspend/resume if system_pm is set to d0i3
Date: Wed, 11 Apr 2018 20:35:40 +0200
Message-Id: <20180411183631.228943422@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477550656600715?=
X-GMAIL-MSGID: =?utf-8?q?1597477550656600715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Coelho <luciano.coelho@intel.com>


[ Upstream commit e4c49c4937951de1cdbe35572ade40c948dec1e1 ]

We only need to handle d0i3 entry and exit during suspend resume if
system_pm is set to IWL_PLAT_PM_MODE_D0I3, otherwise d0i3 entry
failures will cause suspend to fail.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=194791

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2824,7 +2824,8 @@ static struct iwl_trans_dump_data
 #ifdef CONFIG_PM_SLEEP
 static int iwl_trans_pcie_suspend(struct iwl_trans *trans)
 {
-	if (trans->runtime_pm_mode == IWL_PLAT_PM_MODE_D0I3)
+	if (trans->runtime_pm_mode == IWL_PLAT_PM_MODE_D0I3 &&
+	    (trans->system_pm_mode == IWL_PLAT_PM_MODE_D0I3))
 		return iwl_pci_fw_enter_d0i3(trans);
 
 	return 0;
@@ -2832,7 +2833,8 @@ static int iwl_trans_pcie_suspend(struct
 
 static void iwl_trans_pcie_resume(struct iwl_trans *trans)
 {
-	if (trans->runtime_pm_mode == IWL_PLAT_PM_MODE_D0I3)
+	if (trans->runtime_pm_mode == IWL_PLAT_PM_MODE_D0I3 &&
+	    (trans->system_pm_mode == IWL_PLAT_PM_MODE_D0I3))
 		iwl_pci_fw_exit_d0i3(trans);
 }
 #endif /* CONFIG_PM_SLEEP */
