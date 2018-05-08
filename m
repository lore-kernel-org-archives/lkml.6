Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp26DxgKTPs5uA+bpklBiVsQM+nWT7FJIzrnSlTraj4eCIgXzkA4Uig2TJhFAiRcz8fMkHY
ARC-Seal: i=1; a=rsa-sha256; t=1525767112; cv=none;
        d=google.com; s=arc-20160816;
        b=dXPxUTKaTLw/ZDqFfY9RNZ2rj6FYEt7iNI6TlGD7rf3NsAJKb5ThQtBsJYtQVS1z+x
         YXppwwD4y2d0pqWGem3VhfAqtfsaCglgExXKOR8yQ52ak9wjUaLTo/j5Zj2NqlaGoh9i
         gDA6NdOIUGxBkjk7KzSK7jq5zFUB0pZoV9PoumLCNfMKDiuftb3suxjVZGTw4p9z8oKo
         sx3OpS2vsYrE68Hveeo5D+OM/nfBPOuIRFRJm24hGb+jKSNi+ROh1rW1OQ7jCRNsttRl
         nksDE+SmK0CvtdnPLay09yb98JEWuWbi/JOTFLcadmOuLZgOCpCu9EfnXnwE/w9qJ6jH
         ZmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lOd/zngk4O05YkgNFrOTpInqflrRhL0zGt2n2EVdn58=;
        b=PCpVoWChfsDOCAc/ItKhbbri83QIdiJgbuLsD87xv2vs4FrdgDWpy9ajPihaBnT0oh
         eIOB3yeI1Yg2iTeNBThO7TlmGhONmt/z2uM4utguMEnSIwUpuykVa5tcwI7MKm42vBLQ
         bZorGccZ2f5Zcz6YyupSJu6VXzKXFyCloXwjFTwfhkar2V2Wc3Ugy0r7nriMDZE++w+Q
         fvbhe1JQxKrp2/lClWUy8Cnq8YwWFLj07359RAzpj9q9AOJd7a86DDZlFeGwGselXwYh
         02qEYfICc12Bcbyw2vv58wDNnIgpaqVoT1p6O+MhREDBeZHJei4KFxBEYquWVYXjIoo2
         i+zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VKhiflpc;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VKhiflpc;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.16 14/52] swiotlb: fix inversed DMA_ATTR_NO_WARN test
Date: Tue,  8 May 2018 10:10:12 +0200
Message-Id: <20180508073929.930791601@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882776013668057?=
X-GMAIL-MSGID: =?utf-8?q?1599882776013668057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <michel.daenzer@amd.com>

commit 892a0be43edd63e1cd228af3453a064e9e94f08e upstream.

The result was printing the warning only when we were explicitly asked
not to.

Cc: stable@vger.kernel.org
Fixes: 0176adb004065d6815a8e67946752df4cd947c5b "swiotlb: refactor
 coherent buffer allocation"
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>.
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/swiotlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -750,7 +750,7 @@ out_unmap:
 	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
 			DMA_ATTR_SKIP_CPU_SYNC);
 out_warn:
-	if ((attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
+	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
 		dev_warn(dev,
 			"swiotlb: coherent allocation failed, size=%zu\n",
 			size);
