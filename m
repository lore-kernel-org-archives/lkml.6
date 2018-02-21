Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225a9kRjyJpyNWQzFj3l8/qc+nHT/9LZYiqvzc/IYnLSXhus2kQ9PSTRcV0aOuheFEbCvYaR
ARC-Seal: i=1; a=rsa-sha256; t=1519218371; cv=none;
        d=google.com; s=arc-20160816;
        b=JYI102Pb7hFfg27TibazUv1/oesxf0q8tR9flID/n23YAdmtjAYmVGhGiL35YrHxDW
         KjLGARniRjl+vZVPV0rP8llMsKLfWZk1SGQVZ65mQPc/3j1CdwyFkO0BiSHLGf1b7goX
         09rv/hKZJwXHlR2gJCvc4c6DcAp++tniTd+9i/aEreuuSHHloJdKw/tsWYteKhaJT+Pc
         pJSaBCr0QrF8zY16PZ5YdgTy7CqxJYoDjExarIWyI0dNYDQjNAkmHCMZXjuFZagtY6gk
         uW2bwen8BldLXwbFCetFy+slxjeb6WLqBqhtP3n9IP1PR07XveaMErAHG1Yraqnq5mlT
         8Qfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mNnhNLganIqW1Dcc+gnYfxMfkri6ACaQVpLrl547akQ=;
        b=fRwcXX+fjr8cN8buIWpw82WNu8ui1gR3UeXCRjBRqwEwmAiJsl8nO7Yk8EUtsZrLDD
         SOweU5vU1B197n2JxlQWeviB+7MTIzkKGRCRcbUXuMLNs48jEoJ/4pK476qhbByF3jCA
         QEtfj/gfpwbfKEJ9oLqOnaKPdXvt0tr0Ky3G4NxZ4l9G5CZqQ/ZW7zPS9iTVtCncW6wu
         4RGlxYvVJz21tnC8IzmHggJSvnJabsnbRcT3f5NB1wFEISdmHvY+vcEMpc8o5RhwskTy
         YdnURCAtph/6UokNXbd6i7HDxy7PCH+fjKejDCO7NA44tBkkKh4Lv7m9LZrAyJC7Z878
         aXww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xinming Hu <huxm@marvell.com>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.15 016/163] mwifiex: resolve reset vs. remove()/shutdown() deadlocks
Date: Wed, 21 Feb 2018 13:47:25 +0100
Message-Id: <20180221124531.017523032@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015425897320755?=
X-GMAIL-MSGID: =?utf-8?q?1593015923353247425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Norris <briannorris@chromium.org>

commit a64e7a79dd6030479caad603c8d78e6c9c14904f upstream.

Commit b014e96d1abb ("PCI: Protect pci_error_handlers->reset_notify()
usage with device_lock()") resolves races between driver reset and
removal, but it introduces some new deadlock problems. If we see a
timeout while we've already started suspending, removing, or shutting
down the driver, we might see:

(a) a worker thread, running mwifiex_pcie_work() ->
    mwifiex_pcie_card_reset_work() -> pci_reset_function()
(b) a removal thread, running mwifiex_pcie_remove() ->
    mwifiex_free_adapter() -> mwifiex_unregister() ->
    mwifiex_cleanup_pcie() -> cancel_work_sync(&card->work)

Unfortunately, mwifiex_pcie_remove() already holds the device lock that
pci_reset_function() is now requesting, and so we see a deadlock.

It's necessary to cancel and synchronize our outstanding work before
tearing down the driver, so we can't have this work wait indefinitely
for the lock.

It's reasonable to only "try" to reset here, since this will mostly
happen for cases where it's already difficult to reset the firmware
anyway (e.g., while we're suspending or powering off the system). And if
reset *really* needs to happen, we can always try again later.

Fixes: b014e96d1abb ("PCI: Protect pci_error_handlers->reset_notify() usage with device_lock()")
Cc: <stable@vger.kernel.org>
Cc: Xinming Hu <huxm@marvell.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/mwifiex/pcie.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2781,7 +2781,10 @@ static void mwifiex_pcie_card_reset_work
 {
 	struct pcie_service_card *card = adapter->card;
 
-	pci_reset_function(card->dev);
+	/* We can't afford to wait here; remove() might be waiting on us. If we
+	 * can't grab the device lock, maybe we'll get another chance later.
+	 */
+	pci_try_reset_function(card->dev);
 }
 
 static void mwifiex_pcie_work(struct work_struct *work)
