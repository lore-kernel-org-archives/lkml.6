Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22635kvx0fAACbQ7C3YTUI8M6cPJsjAiX/yCzHC2bwaOhAgT67UeEiVopeK94IZw/HtlSgQP
ARC-Seal: i=1; a=rsa-sha256; t=1517591354; cv=none;
        d=google.com; s=arc-20160816;
        b=dNhYZsMCt5NnxJ1gcoZyTgIX9X8Loumj6jVhLrYrM1dCGLZI/yYggrFOkU/Q3smgPt
         0mHOXskRdrw3MvcIJo7ozF9/hze31uaaBUqMinbKJNmpS1D7QNWDBJMb6zlNq27MOG1w
         getDQ3FID1S7Yh1oppdrj9o89+iMVRl70tMriJGR46ezN534VE8U7AOc4i/7cW42gvdy
         gH9JnCQaIv/qQKGf+sdkNzJNJRfunzw2wIQ7DTX2JXUZpIy6fUM250Z7Iklj2lzgdrz0
         8OqXJX4/UfDGBSFPcb8Y/YGboqEocWYZ68m1zSJSIb0+MKq/GTHi3lL3J+ppJTx0J5fN
         Q6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SzQqp1Kh1WzHCrhEY3SYr7rZKd5DqWNOL0tkg/MJfd4=;
        b=mgGV9ASEmKxPLYbgJw0RPuBLfV1upBEuCiStwuWK4c+hupPilhYoqk/f2Akadwfv9O
         qQWpaHE0cMzI1I2A1ERIiYtqMC9WZxJTsL2rHH7OKJwTgHA0F97ZKb/v6mDzKuuk0OAu
         1s+XakmWToOUZzJkg/y1179sbfnOMPyMzhmjX73tFntcAjWwFf/nPTR+PP3bdW5JJNMQ
         BdNQZXe00NKY9rnwVeHQYJ9gi84l27kkqzCjogDf9ciRmyU1tAGW7SRH2pgsU0y7EyHM
         7evsoMn/IkyGAaFABo8Y5LxSN+yzOSFqzB9xPneMIhYl8EPmjpz1uxN7cDGhyrpszHhJ
         rtTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Minwoo Im <minwoo.im.dev@gmail.com>,
	Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 050/156] nvme-pci: avoid hmb desc array idx out-of-bound when hmmaxd set.
Date: Fri,  2 Feb 2018 17:57:11 +0100
Message-Id: <20180202140842.549809202@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309871566996306?=
X-GMAIL-MSGID: =?utf-8?q?1591309871566996306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minwoo Im <minwoo.im.dev@gmail.com>


[ Upstream commit 244a8fe40a09c218622eb9927b9090b0a9b73a1a ]

hmb descriptor idx out-of-bound occurs in case of below conditions.
preferred = 128MiB
chunk_size = 4MiB
hmmaxd = 1

Current code will not allow rmmod which will free hmb descriptors
to be done successfully in above case.

"descs[i]" will be set in for-loop without seeing any conditions
related to "max_entries" after a single "descs" was allocated by
(max_entries = 1) in this case.

Added a condition into for-loop to check index of descriptors.

Fixes: 044a9df1("nvme-pci: implement the HMB entry number and size limitations")
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1645,7 +1645,7 @@ static int __nvme_alloc_host_mem(struct
 	if (!bufs)
 		goto out_free_descs;
 
-	for (size = 0; size < preferred; size += len) {
+	for (size = 0; size < preferred && i < max_entries; size += len) {
 		dma_addr_t dma_addr;
 
 		len = min_t(u64, chunk_size, preferred - size);
