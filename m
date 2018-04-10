Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48l61kIYv5W/RDPezA1R2EvmcHWKJ8SJX+B337wVNITmD/aOkagWI52x7fshQT+voPLJ5bb
ARC-Seal: i=1; a=rsa-sha256; t=1523399379; cv=none;
        d=google.com; s=arc-20160816;
        b=K1aOmSMD2vEbqLXFOizw0+h+imEB84RBKrVzMo7RcEwU2iUOpxQWy+ysjkqhDXQEBA
         1/7hctKXmNFtcPRkjbdpZf5tHfzFZs/dQWE66sH18A2oguiDywfp3nX2iICP+vt6ci9i
         pdbpobZ77NjngaLvyJG6rv2lOeEjUK5JKMatOFId0DW7IQrtm/TDPA7aCAXNMPXX9F2y
         260uWDyvWhCfuZsrfjM6+bcUelopO1ec7nZOdgzt2VzDZDnRqeDSK/rJQ3Fnm0ug7bQV
         PBakkMUCZbrwmpQ5kAPB/Dd9NjW+3y/wENguy2rfH+SmrdU+jv5B1TlWIdcAoO9AZ8HF
         6WFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Yr5J/IWq8IeKXqrdOkLV8bc5jMEzwrw/Rpl1+IMSQ7M=;
        b=gF7l0oFq5VaTvXZEbJAsukV9M38A1cxSodhcYhLOWeAdQmyiB6hyYn105e2p35W0Oc
         W2MmjWJTI04/v6IRkbPAsAq2VnAnuIfZLDnBzAgdLiTyZva2w1/lsEtnFvq5bN9RC5Tx
         9lPD2QNpcncNqCeQV6ON3t5T+F55bHeLoxUBLQ0h3yDCF0j3kMUg+rbzFkNQY/ksuxh4
         FWaHlhFcMj2vuplfvYRP1Q/b8tS2hRZXUXr6zvrmlMtfOI84kiJVXH1osI/7CC+kYOiD
         E5w51fAWdaxClAX1V/o7X3MzK7DS+5PTLnhuVIBru2z321+mt2JPmcLeCu/c4W+AB8kY
         Yc9Q==
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
Subject: [PATCH 4.15 086/168] uio_hv_generic: check that host supports monitor page
Date: Wed, 11 Apr 2018 00:23:48 +0200
Message-Id: <20180410212803.929432437@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400027759184207?=
X-GMAIL-MSGID: =?utf-8?q?1597400027759184207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
