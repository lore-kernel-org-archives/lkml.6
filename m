Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvs4gDOJhli+34mSuE9H6Tvr3EuLujB1IdXs0Zo25o1E/5oJFbiJ2p0jITlUmXjtIG7ffGM
ARC-Seal: i=1; a=rsa-sha256; t=1521483835; cv=none;
        d=google.com; s=arc-20160816;
        b=MSsvm4HQ2pdRFM1Ab2P+8n9uGCVwwDglA2TJhgcg/Y1oB2PECoIWtitL71YCfw8Txt
         PrS2mlMoxn1P90aTheU0Rcq+Rsbjra2hA4IRfxenZajuU8s8uEZWAurW8QHr0+JiUBYl
         q6cbi++LoMpiC9dUl8+e0VcnKI0/x8xY9QPj6Dr5wfWzdQsO6lzpuU6adJJRpW7iN7n8
         ZtnI9KAtjTjixgNcG64B4mio4EAAH53OZ28xcAxpfCe4AZXVUktCC94A2tz48UXS3bFC
         QMSH9NZXzNgcVvJ33ziTMm6Nrms4oH34Skt51vA406G41/kh6Xk6KafYDYRraGT4pPOu
         lasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xKHi4LZWAPYpi0tnVaqCgo55mtRW7IBaleJzm76XlYU=;
        b=zo5NEM4C2wPGXtrpajbPqyFgC7rz3S6OntuGdiYOYjhjGB3juppEFL1oy+kySTyAyt
         MUu+9EEnsceAfew1yGqOTZl7yJMsa5Pem99kwmYfSOfeGE5rB0QeCyDrWybSSGRu8IvL
         /dLVv7E47hrfXECitV+aP6lfz0c9Ksz7YblJVIohZ2kopynvl4zt8Hg3lajmMCQ898KB
         rTKrhM2Hc37CGAI6trh9saZw80uyDkrzbNpNdMAfJoMpsXBKsat67iYVhDXDJnM/iyqa
         eSNYYx1L4eOjIcKdRA0rYJ68Oq/Ii6Z7922OVivs32HAUUBBkgniNQnvw/orND1pDX4I
         iaig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 133/241] [media] v4l: vsp1: Prevent multiple streamon race commencing pipeline early
Date: Mon, 19 Mar 2018 19:06:38 +0100
Message-Id: <20180319180756.700122392@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391434710949149?=
X-GMAIL-MSGID: =?utf-8?q?1595391434710949149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


[ Upstream commit 4461c84b52b4a952c657505ef7e4e06b016783df ]

With multiple inputs through the BRU it is feasible for the streams to
race each other at stream-on.

Multiple VIDIOC_STREAMON calls racing each other could have process
N-1 skipping over the pipeline setup section and then start the pipeline
early, if videobuf2 has already enqueued buffers to the driver for
process N but not called the .start_streaming() operation yet

In the case of the video pipelines, this
can present two serious issues.

 1) A null-dereference if the pipe->dl is committed at the same time as
    the vsp1_video_setup_pipeline() is processing

 2) A hardware hang, where a display list is committed without having
    called vsp1_video_setup_pipeline() first

Repair this issue, by ensuring that only the stream which configures the
pipeline is able to start it.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/vsp1/vsp1_video.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -792,6 +792,7 @@ static int vsp1_video_start_streaming(st
 {
 	struct vsp1_video *video = vb2_get_drv_priv(vq);
 	struct vsp1_pipeline *pipe = video->rwpf->pipe;
+	bool start_pipeline = false;
 	unsigned long flags;
 	int ret;
 
@@ -802,11 +803,23 @@ static int vsp1_video_start_streaming(st
 			mutex_unlock(&pipe->lock);
 			return ret;
 		}
+
+		start_pipeline = true;
 	}
 
 	pipe->stream_count++;
 	mutex_unlock(&pipe->lock);
 
+	/*
+	 * vsp1_pipeline_ready() is not sufficient to establish that all streams
+	 * are prepared and the pipeline is configured, as multiple streams
+	 * can race through streamon with buffers already queued; Therefore we
+	 * don't even attempt to start the pipeline until the last stream has
+	 * called through here.
+	 */
+	if (!start_pipeline)
+		return 0;
+
 	spin_lock_irqsave(&pipe->irqlock, flags);
 	if (vsp1_pipeline_ready(pipe))
 		vsp1_video_pipeline_run(pipe);
