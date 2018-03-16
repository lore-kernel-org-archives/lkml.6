Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtxBl3/4BLpuanpJqqqhF+RX9YCrNpfvWvlhDJRQvoQTFcXtRvFdiHtY3nyh+ewNJv2TQD1
ARC-Seal: i=1; a=rsa-sha256; t=1521214682; cv=none;
        d=google.com; s=arc-20160816;
        b=rqW6Pd9ZmT4jla7GkRka9W+F5rUwFmojHqEH8Cf7sWlzn+bBog69nBjcKH7OqoimIZ
         nMBH6Ne9TH9xL1VtyMsn3Hqw+EqVXkRDv4E0e2QjNrXw5uWOw50LprrJWF3zd6Bh4D95
         +56CfNx2GtsRLd3aYDfc7aADHwcugj/SCdj5H+VzXnk/jYejVWBqRIOU/fkzVE1307n3
         vte13jRzWGqNlR2z87q0GCtJjXAfnBk7gy7L4KBkWb7dQ5fXq5M395Aq2+X8hN6HiSnu
         uqpsjjEaSA6V3uoScyOU6kYn7ideodLKYcr0F/Xt5s4FK2yehYK4207bx2IlIAJSQen7
         Bn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uVYXLfG7pwAZ5hm5rCJTq62cWYXM9D1A173JMbzlWm4=;
        b=A8vGDAVQfSixnkmcF6qoz1sPPlv6NJ85eKoA9Ji2pKh/LrSH23Cz9YX/DXpprjxL6M
         Hnpz9pCZktQAh288o6iWaX44eXRcz+wlzyQVFpABpXv1dAgJ64RMN12BqCSV97ej0+Nc
         BWz+C9yX0juCXe+CtEzlUDoBpJXlppziRwDEZkThy/rh50W/j+ggTHTChXbdcVg6/3r4
         S/9KoPyNs66OyP0SVCz3ji9sgr1d+W0oBGPqFkGbss1WRKYotuqKaX/AOeUkcWzda4OF
         BgMayJJS0H9OcF49AQK08iEVvPqTioJDkR64zkisN/yOB5Nvn7LA1DI/p0VHX+PY+7fA
         uVvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 088/109] media: davinci: vpif_capture: add NULL check on devm_kzalloc return value
Date: Fri, 16 Mar 2018 16:23:57 +0100
Message-Id: <20180316152334.717839256@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109206970559715?=
X-GMAIL-MSGID: =?utf-8?q?1595109206970559715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 5a18c2434f8bfc8bc2fb0f8af3e44f7408d63e4f ]

Check return value from call to devm_kzalloc() in order to prevent
a NULL pointer dereference.

This issue was detected with the help of Coccinelle.

Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT when available")

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/davinci/vpif_capture.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1545,6 +1545,8 @@ vpif_capture_get_pdata(struct platform_d
 					    sizeof(*chan->inputs) *
 					    VPIF_CAPTURE_NUM_CHANNELS,
 					    GFP_KERNEL);
+		if (!chan->inputs)
+			return NULL;
 
 		chan->input_count++;
 		chan->inputs[i].input.type = V4L2_INPUT_TYPE_CAMERA;
