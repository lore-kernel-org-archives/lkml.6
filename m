Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49BDJjNbNueMz6SDTJHbp8lYY+um4smsrdHyF5Vt51p1NscGJTghJYQ3MQdzPgsiMSnjW6A
ARC-Seal: i=1; a=rsa-sha256; t=1523399346; cv=none;
        d=google.com; s=arc-20160816;
        b=gBazhOQudWeHbkd+Fy087uea6RWyg63y+VpzhvuC//6VF1/3tC71JsH23YI+eiRmF6
         jGdjkt4EB4TOvFL728UXnxcikZL/0orUbY3GkzJd9EUC6kXk/en6prXbH6JsYhcXXqW3
         AacE9gzzGRM3YtancQZEk01rdWeWW6yLeL0zD17IRZIvlvimU+mUU5IdgMwtCQAthKr1
         dXujYtk/+LvRiPIvZ9edGjp4Eag1AJW1giBj97HNI2WI66gByvQVjmwpBQPuh7yZjp8r
         Gk5ajHOTtJ8owX1fWrxBD/6XBMA47RoZwsS4conaCtMml/EYjvw+UjutVg1d27wgTuqM
         JUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YNdCF8nxpHafpNJAD/UClDJVlNiDlTb3OfT7ZPEKde4=;
        b=EXH+8RoCDFrO0lBOjhvz1WWAMtSdkW8HcHZb1hBadIrze46OPtGY15KowhW6Y9N3Bd
         ZAvW/KQLJqpq6vT6Q9hjLGfuPcsIHYZFYRmG92H6LKx2EWvyuPCFShEDeDCZUM7GXGN3
         OhhsrFCjYTUOikXfnnOh6e7lQqs69b+IiyViPxSijqy9CdXMgKCeqPx0J1j7ljxsoIXw
         lzHU5cDQDTJjRY6t8S5zZ66kY6oFB36aX9ju1z1vwJTWIAAML4tPrHlsGG0ycGFiiwud
         uep8/6zoeu49hBrTbCCtrYGmHhRx5m7rLY929F6+utZh8sDVq074Haxn8XiL9FCZvpMy
         dRyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4.15 056/168] nvme-fabrics: dont check for non-NULL module in nvmf_register_transport
Date: Wed, 11 Apr 2018 00:23:18 +0200
Message-Id: <20180410212802.601450885@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399993582621123?=
X-GMAIL-MSGID: =?utf-8?q?1597399993582621123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 5a1e59533380a3fd04593e4ab2d4633ebf7745c1 upstream.

THIS_MODULE evaluates to NULL when used from code built into the kernel,
thus breaking built-in transport modules.  Remove the bogus check.

Fixes: 0de5cd36 ("nvme-fabrics: protect against module unload during create_ctrl")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/fabrics.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -493,7 +493,7 @@ EXPORT_SYMBOL_GPL(nvmf_should_reconnect)
  */
 int nvmf_register_transport(struct nvmf_transport_ops *ops)
 {
-	if (!ops->create_ctrl || !ops->module)
+	if (!ops->create_ctrl)
 		return -EINVAL;
 
 	down_write(&nvmf_transports_rwsem);
