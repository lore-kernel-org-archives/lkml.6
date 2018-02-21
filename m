Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224beR6aGZZjQkKs4hJNVEsdzOImYRUdHp7hI7k6jHL8aWSy+IoJ3/Wvl/BiSXVh4zRFUzDf
ARC-Seal: i=1; a=rsa-sha256; t=1519217897; cv=none;
        d=google.com; s=arc-20160816;
        b=nCm1H5xh38emyUqMjLiQa/VWjaUl+EwwQi2ajtS2DTyVZfrNezGhIAQtrGP/gfKfgh
         UdsLMZLJTtv1jyGm5sTOG9/Dgy+j/+ou09eluSWFxhV7XB5uQJNSVBiGPl7AgB8Sz54x
         fV6ifu9Jk2eDFat6pF9ckErmBmaHVndsXOgf6Ki7yb4mMUZ+iz/6lDi66UuJXpUZl895
         9okIB5JGIKoJT9lEPSZ/yFBa87RF5FKr5S+QGxYG/IEtRbJHM6Cl2r21xPDSVzhTOWa5
         myzmqZcM/UdPiZDHYA4g/J6GtkAaO+gdxUwvgmUZHyfvCx34pbc8jPnG0YS31INFJukt
         WQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tHI60DHSl2mdorovP1x8B1vBfYgC8NZyS6KI8EZ7KrQ=;
        b=0cXYNCwfXWII90PsXZVdQiPFZdvtN003PQeQXqwEAofRqPvxweTuKDLwBPYxuL0XMQ
         DdZtTI8IV/a3BmzEeJxjw8CG72gonTzLHOdczAyWJpDEoGVMwsJU6PFDXy5qFyjt+TO1
         ulw+YICKG9T2tHWKABxJDNIb4HNsTyNZohgKCMtph2oTCOuRkkImODQhxTgjjmAIG4VA
         i9EoyJccazP86XEl6a4EUOwudhu5l9TQjhxYr1pW7QFCbkiOEVag0KD8ADCcLpHk3e28
         W1J6vQI/Y/eIxlHctUZyqhpIDvLFRyficv9nezs4jIR0B8RG0FWruimtatoTBLNhOjT0
         LDUA==
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
Subject: [PATCH 4.14 017/167] mwifiex: resolve reset vs. remove()/shutdown() deadlocks
Date: Wed, 21 Feb 2018 13:47:08 +0100
Message-Id: <20180221124525.562795649@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015425897320755?=
X-GMAIL-MSGID: =?utf-8?q?1593015425897320755?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
