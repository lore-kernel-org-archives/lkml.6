Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224v38Nl/eAWqH7EfJ7mG1rNIJVXehhkkk26dO7xthcnbAHSREceWLgJjbgsTc7YDkYFxnwu
ARC-Seal: i=1; a=rsa-sha256; t=1517591685; cv=none;
        d=google.com; s=arc-20160816;
        b=iWAVLuuvrMJW+Bt/cjmHax79j6roihbXS3WkTRxfHdA8NuMD9KOJ9hSX/F7t2b0Eel
         RrAXKGJt8P7X2QRyyMjbdJOOY01U5Rwq6kMXdcckW6kfhavfIXQiLlhRujJ6hUaylE9D
         v7Ry5zZxiv/UX0+J9fA0xPzJTl3ZlFSJdiT6w15pqqmAXMD1OKjvmeJclbW3gSPDHpVx
         zC9EhhvvnF273uskonSLptUR7hFqz/mZwQ2ImN9u1kM281Xgzl/nlGbUiDN9wlQjakZF
         a/idBwRUNeLwYoKA2HcrI7RcqwR+x1l9PFYgRV37HzDFLDYrtoF74GC5xJox8TR4FemZ
         /fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QhxCSSjjVOgO33E6FxyrqOnA7KAfq0tM7ofNxqEIVsY=;
        b=TPVBfn6BGE01+twTHR2coXjlMF0ElI2KfNNwmh6yo3zUucTbSFmmYoTCKwx51vuugI
         F6WP7PIGZtmd/fm/zRmHkovoK+LlEx+6gKQ+Q7JQBIIX1Ymv6JZQn9BQZUxC6EvuZOPV
         h8bSKxCPTb9nTTTHzyhXv+bBH58/s0VvXcBb+cPFGUUVNJdBumEMIhheclCDP4AXwfFR
         zWZUOlW8aQoc1JC3EHUzIJoYaqa+nOAN25FtfKmsQgSMlSZJdahqFOPbI5FddnTNOaUO
         OfVgfqfheIBuDB/oMd0StA5WKaCg7W+ZoDcGuAXi1QnDJaUfsdD8okRc2FCG/4V+Pkac
         2gzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
	Rob Herring <rob.herring@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Lukas Wunner <lukas@wunner.de>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.15 01/55] Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops
Date: Fri,  2 Feb 2018 17:58:19 +0100
Message-Id: <20180202140826.214170110@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310218934404837?=
X-GMAIL-MSGID: =?utf-8?q?1591310218934404837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit d73e172816652772114827abaa2dbc053eecbbd7 upstream.

John Stultz reports a boot time crash with the HiKey board (which uses
hci_serdev) occurring in hci_uart_tx_wakeup().  That function is
contained in hci_ldisc.c, but also called from the newer hci_serdev.c.
It acquires the proto_lock in struct hci_uart and it turns out that we
forgot to init the lock in the serdev code path, thus causing the crash.

John bisected the crash to commit 67d2f8781b9f ("Bluetooth: hci_ldisc:
Allow sleeping while proto locks are held"), but the issue was present
before and the commit merely exposed it.  (Perhaps by luck, the crash
did not occur with rwlocks.)

Init the proto_lock in the serdev code path to avoid the oops.

Stack trace for posterity:

Unable to handle kernel read from unreadable memory at 406f127000
[000000406f127000] user address but active_mm is swapper
Internal error: Oops: 96000005 [#1] PREEMPT SMP
Hardware name: HiKey Development Board (DT)
Call trace:
 hci_uart_tx_wakeup+0x38/0x148
 hci_uart_send_frame+0x28/0x38
 hci_send_frame+0x64/0xc0
 hci_cmd_work+0x98/0x110
 process_one_work+0x134/0x330
 worker_thread+0x130/0x468
 kthread+0xf8/0x128
 ret_from_fork+0x10/0x18

Link: https://lkml.org/lkml/2017/11/15/908
Reported-and-tested-by: John Stultz <john.stultz@linaro.org>
Cc: Ronald Tschalär <ronald@innovation.ch>
Cc: Rob Herring <rob.herring@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/hci_serdev.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -303,6 +303,7 @@ int hci_uart_register_device(struct hci_
 	hci_set_drvdata(hdev, hu);
 
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
+	percpu_init_rwsem(&hu->proto_lock);
 
 	/* Only when vendor specific setup callback is provided, consider
 	 * the manufacturer information valid. This avoids filling in the
