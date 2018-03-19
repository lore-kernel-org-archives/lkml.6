Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsVb4RK+pEb4iyVEBQK5RKAPaC3+DVNHimKh6F2/icG6ZG/o3YsAmZbnIXvtzAnuY6ga5k/
ARC-Seal: i=1; a=rsa-sha256; t=1521483269; cv=none;
        d=google.com; s=arc-20160816;
        b=RGZWSMiOCbNXaG+RrbBZSNq3htisVMPE42JUOOJ06al/HqE3rcshHhAMghKYZZ1f7Y
         YQr8smDGkCzby74sWvNuWPA6cHswTZSRjoqS6dRG5EFkYxSl91SF0Y4LKFvVE1JfO5P5
         sg6CQ0lnufAemcEpyBRNac0h8+GUHjVwI+I2Fn3ujz7dZxAlhiHvj19irhIJnCjOFcxb
         /Y7xFCmGmvd35UU6iA5dXB0rT74PFkz0k63VmdkjGPOhBhEi7uxppksr5W/dWk6HeBmf
         HX2mKc9qzo60vFf6qT2Na5BGQ3yiwcpVTXYOK5FwGrjWIQsvZ4FE8mQ0Tg6Wqrad+6Vv
         wurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R9so2eTh9LntcYSgco/L5xEZRjiaT9FyFrul6vboqy8=;
        b=NEyciDsvX1Ing1UUdtsHAvQnp8nM7WxpR5KoqjCRZh1Po9zgc10bVI/Q6jog4/vwa1
         +8V2Z1Vp0z1IAJ6aJeYFSdE61gziYY28fFj3jPaIDlwYaKU+Y7DU+8Q178NiA75UK51C
         ckxP0MzicW5J2YbbRAc/mYjfobZ1wE2gGofvasA9/toMuQ3HJwlgAeu2NSTW5aGco/kq
         AiK4RTarFZRvhr0btbHzuUdIxb0G6QLeTmJI1ZW1CT7aCM/RWpdIMpUYuUHmtC39GMG1
         fatej/vss8Aw2XEc4ipfuhK6tto9xy5FZ6zp8eikyqpEoQflPFXZaBHqBx9fislNIxl/
         4g1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Leach <mike.leach@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 061/134] coresight: Fixes coresight DT parse to get correct output port ID.
Date: Mon, 19 Mar 2018 19:05:44 +0100
Message-Id: <20180319171858.124822699@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390840577337928?=
X-GMAIL-MSGID: =?utf-8?q?1595390840577337928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Leach <mike.leach@linaro.org>


[ Upstream commit eeedc5421dd3b51de73e6106405c5c77f920f281 ]

Corrected to get the port numbering to allow programmable replicator driver
to operate correctly.

By convention, CoreSight devices number ports, not endpoints in
the .dts files:-

port {
     reg<N>
     endpoint {
     }
}

Existing code read endpoint number - always 0x0, rather than the correct
port number.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/of_coresight.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -150,7 +150,7 @@ struct coresight_platform_data *of_get_c
 				continue;
 
 			/* The local out port number */
-			pdata->outports[i] = endpoint.id;
+			pdata->outports[i] = endpoint.port;
 
 			/*
 			 * Get a handle on the remote port and parent
