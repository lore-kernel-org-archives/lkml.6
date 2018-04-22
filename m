Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Qii31cm5bWDbevy3XfeMPfXs/0A6riGc0fOXDObliSrs1jDb05WfmlAGC2/xNzIDvketL
ARC-Seal: i=1; a=rsa-sha256; t=1524405340; cv=none;
        d=google.com; s=arc-20160816;
        b=dt/Rq7NY6fZZktrajGRKNBfE+Oz7AigqGU+YghvyVgzhFkZjbSMFzC00dM88tgpk7x
         P9+M4EDNFpXPObu+S6Ggk1yJREabkt073Hux6/Wym3a303DnxYN1L7bFPeAAyBii5DQo
         2WFMdqn3TJYj4HhPHh7sZWXunFfDfSHLa2PhczPGtHH9FZMVZiiF9n2YfFvQSs8OOpks
         TmDafPqjghehSyFvrUm22zo2dgQ4MQdBdcGiqpDrXFfonTYl9OnjLYRYU/F/XqQ8qn72
         b+f221774tU1PaFVKGjYyFCTXjUNkkbW344i/YAvclpcPRONKJvrW/V48WRDs0HotriQ
         7TrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PgoeZu5KTFaLkfuw99stq/5vwoK9D6ixjdSkQkq2H5k=;
        b=UAHXEVYpmTf9ONeeaa34iP7XJOR+B3pNRNN9hwbSDek9lpabdn62T6JKtR1kDnnlGv
         cYyDYGa8idtV+GKm+VWir1oPjo0mrrOGoBSN90wY1n6XwQVq7Ue2caOuUBRLbgdAuSTo
         nNLwM0emGNGk9q5QXBqAax9HoFRF+xH2TpJ6lmCOjITKLbicKBAWeH+KP/u1USjV3rR/
         qQNvXN5V92IWrpHELFxLFEUoTrKE5OVP+/V4DL7uqCr+9XWQwTzWzC6bbncbO+jYojFj
         ZUk1kgPX0COH6cle0US9Q7PS0IBXduZRPKBvhScYmIeMMKRUXPVVpWm/WU0918xCASUM
         Nx7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.16 030/196] media: rc: oops in ir_timer_keyup after device unplug
Date: Sun, 22 Apr 2018 15:50:50 +0200
Message-Id: <20180422135105.663230626@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454854474207024?=
X-GMAIL-MSGID: =?utf-8?q?1598454854474207024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Young <sean@mess.org>

commit 8d4068810d9926250dd2435719a080b889eb44c3 upstream.

If there is IR in the raw kfifo when ir_raw_event_unregister() is called,
then kthread_stop() causes ir_raw_event_thread to be scheduled, decode
some scancodes and re-arm timer_keyup. The timer_keyup then fires when
the rc device is long gone.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/rc/rc-main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1929,12 +1929,12 @@ void rc_unregister_device(struct rc_dev
 	if (!dev)
 		return;
 
-	del_timer_sync(&dev->timer_keyup);
-	del_timer_sync(&dev->timer_repeat);
-
 	if (dev->driver_type == RC_DRIVER_IR_RAW)
 		ir_raw_event_unregister(dev);
 
+	del_timer_sync(&dev->timer_keyup);
+	del_timer_sync(&dev->timer_repeat);
+
 	rc_free_rx_device(dev);
 
 	mutex_lock(&dev->lock);
