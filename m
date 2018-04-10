Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49oemnr5i8cqVFmC7kTqmmP8wMOSypUy2rbjkcIa0IkzNGjnrI3uTtFm4w+3OP9V2jbdUw4
ARC-Seal: i=1; a=rsa-sha256; t=1523399872; cv=none;
        d=google.com; s=arc-20160816;
        b=dRrejE/BGF/RmceS3cPKOcEW2c9gpEmkhvdCg60jcXKVO42oSSgCNJFyQsMknnci/l
         QMwu4eD5tg5hV64kuuowY2OYEtvjvKLLH8IlNWq9r8ZmEkDOW5/bMAXBSPNPmQeHX3T+
         Btl9z1OUE2DAH46e5Ee1GnoDLw5R7zWUwo6AOptOExXtI1JLSgH3jrCaBItf03eR7Bzw
         ERFCkj7n9szq2UEddpj5uC20vyKMsvqRMRDICS3kfcCLO0ye1bF6IocpT6iij74daSc/
         J5R7vRMBxbYOLr8rFPdN5KjUHAV3amPtdV9O92esqVFw07e0cNMW+I3KiwI17+Gvg+Wz
         Sn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TBgYUXB/k2aVqzHTeCgE9TO5hW6ZMKyzSK7mpnlvUnA=;
        b=tOdt4EWrwdWZhpEOpVmVL0wBrxatsZpkclStHKKcXtmneg/uLqqKd5n0W37AfIbO05
         kuSm1zjUYHp8jUp3V27IlWxdTyPa/8SQ26LmjEj9iJzwj7EYRvkLZFkVhNYZXigG+ofr
         lPvNAD725fGBsoRceZA+EzjBtG7N/PzXTGwoOjFhDBqFy/K7PLVWXl1l0Tg1+RdzWWTm
         qAvbjFDeYoobXJiYRSYvgJMQgqUNB7/QWooE5e2nrh51NDjXIDYHvBY+D9enw/0FSfDw
         hgGB2s2u8SwTfC4kYfpkcsejRiTrtIWl/Yw6oBYt00jJfmW9SmLFT1bfBnAcK4zVBNy0
         3oRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 067/138] uio_hv_generic: check that host supports monitor page
Date: Wed, 11 Apr 2018 00:24:17 +0200
Message-Id: <20180410212909.891477166@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400027759184207?=
X-GMAIL-MSGID: =?utf-8?q?1597400545190219006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>


[ Upstream commit 06028d15177a1b406b7b075ea47c6a352732f23a ]

In order for userspace application to signal host, it needs the
host to support the monitor page property. Check for the flag
and fail if this is not supported.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio_hv_generic.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -124,6 +124,13 @@ hv_uio_probe(struct hv_device *dev,
 	if (ret)
 		goto fail;
 
+	/* Communicating with host has to be via shared memory not hypercall */
+	if (!dev->channel->offermsg.monitor_allocated) {
+		dev_err(&dev->device, "vmbus channel requires hypercall\n");
+		ret = -ENOTSUPP;
+		goto fail_close;
+	}
+
 	dev->channel->inbound.ring_buffer->interrupt_mask = 1;
 	set_channel_read_mode(dev->channel, HV_CALL_DIRECT);
 
