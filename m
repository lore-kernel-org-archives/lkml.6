Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtC7oY5uCLFVzaN/qIYzFmR1bG8qYRElqIfuoOXK3/Y/1FLIVEQhTuw9Fmt9/2QnhVcgcXe
ARC-Seal: i=1; a=rsa-sha256; t=1521215008; cv=none;
        d=google.com; s=arc-20160816;
        b=OrzSrEp/PEy5OvkHoG7bHp7pLhRAhm3aSnnonOXgNw+wDhzvigCkmtlnDLHtbyCsEe
         oHocP75ZAWPi4RW5V4j8+E3GSFJsd6z6MJikgyNkjcck46jW0TBDrzwxgZxEOWz3cgl8
         kgi4uACnQlMrnnSe0oCIRH/NzO/ogW4ObMXvUkc9VMH3akSRBIu+UH3huMRdcxzkr4s3
         Fo0LLhlS33bCrAv9wFVfrlrOa73tpYiO2Y+W+8EVA91cGYSGt8j0SjzpjyjGQXE9sM01
         6MjZw1eQ857d5XW0IGtM60C/ZZqyxQChScAi0ONxCKvsDv3VofzaztgFVnJ08Bp4udR6
         OGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ywWvcA2SH3obzGp8Ty2KhBdpHZUoTf8R11F7EtH4mXI=;
        b=yVLv9NyascL1pu0JVH+1+QwWzdsT5FY5FalBLYFIA583Vv97pYrjD6Ey5OWZzICFdB
         rofylzJa8OAU3l1i41MENwIY/HvD5xI0zAMcZ0/OdPeK/2m/5stvI4dv+8nomJ5XCU5T
         3Fhb8Kp80gw7KJnpekHrT5PS7BSgN9vBZfo/R3si7+8gSwwAb+e1/BbZHfA66vEbyBY2
         OBFcVqweswd6UCH1o0Zo0miBoZ2pORtAJBttQC4V9R2wBR3NWBR4crIwJKBDsvOvPv/h
         gkVmFa1DGArCEg4rRtV8qyX04pe6Sx9aYrdamq75SC/TmjoSMh71uFTb8Kf8noDQH+AP
         8UwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 078/128] dmaengine: amba-pl08x: Use vchan_terminate_vdesc() instead of desc_free
Date: Fri, 16 Mar 2018 16:23:39 +0100
Message-Id: <20180316152340.552983019@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109185262445571?=
X-GMAIL-MSGID: =?utf-8?q?1595109548791228257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>


[ Upstream commit 47d71bc75d072ce25c1063aa629e55e1cfb961b2 ]

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/amba-pl08x.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2182,7 +2182,7 @@ static int pl08x_terminate_all(struct dm
 	}
 	/* Dequeue jobs and free LLIs */
 	if (plchan->at) {
-		pl08x_desc_free(&plchan->at->vd);
+		vchan_terminate_vdesc(&plchan->at->vd);
 		plchan->at = NULL;
 	}
 	/* Dequeue jobs not yet fired as well */
@@ -2193,6 +2193,13 @@ static int pl08x_terminate_all(struct dm
 	return 0;
 }
 
+static void pl08x_synchronize(struct dma_chan *chan)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+
+	vchan_synchronize(&plchan->vc);
+}
+
 static int pl08x_pause(struct dma_chan *chan)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
@@ -2773,6 +2780,7 @@ static int pl08x_probe(struct amba_devic
 	pl08x->memcpy.device_pause = pl08x_pause;
 	pl08x->memcpy.device_resume = pl08x_resume;
 	pl08x->memcpy.device_terminate_all = pl08x_terminate_all;
+	pl08x->memcpy.device_synchronize = pl08x_synchronize;
 	pl08x->memcpy.src_addr_widths = PL80X_DMA_BUSWIDTHS;
 	pl08x->memcpy.dst_addr_widths = PL80X_DMA_BUSWIDTHS;
 	pl08x->memcpy.directions = BIT(DMA_MEM_TO_MEM);
@@ -2802,6 +2810,7 @@ static int pl08x_probe(struct amba_devic
 		pl08x->slave.device_pause = pl08x_pause;
 		pl08x->slave.device_resume = pl08x_resume;
 		pl08x->slave.device_terminate_all = pl08x_terminate_all;
+		pl08x->slave.device_synchronize = pl08x_synchronize;
 		pl08x->slave.src_addr_widths = PL80X_DMA_BUSWIDTHS;
 		pl08x->slave.dst_addr_widths = PL80X_DMA_BUSWIDTHS;
 		pl08x->slave.directions =
