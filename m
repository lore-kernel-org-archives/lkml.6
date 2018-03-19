Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuL5j4L8KZJzUEiBss6UEaC1N/4nvp+BZXL6mQ5VJDxj/MrQbSuaDXkpo57IdfcDf0VOhKY
ARC-Seal: i=1; a=rsa-sha256; t=1521483004; cv=none;
        d=google.com; s=arc-20160816;
        b=leIfa3w95c/ZEkBWISz40RrFUjoEWHIstf09/go10fXSTYub2GEx+Vk4M90ww0KVfA
         Cfj8MWvI8yde7G7csyqHu4/yYAL8lOLZyfS0Lhb9h8+tqA8HiZ1XCxwQOnAoS7ux8GzX
         a/+fvQS4fJVRCcu9YMrYf6WGReyqmonPYMR0Tpwimn53IZYTNKKK5uDI4PEmy4ww12yi
         xNH9ghP5onZMePTOF+QVFcJ4TJhoTvOKW24biNSnssr55Y8rWnfbfKk+9u+iz0CL4VCa
         J72wQSCOKaQPV4jFibu0iC/YVi9h9FBYym2xqXGTesVPt3xpJ1qBXzBd8TcQOjoB4MSt
         m4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/BsrWoaFl2XsutFAUSvJct1ZJ+iR9W30ZnxaXVWN1V8=;
        b=piw7uiMOqdgRDkUqtZyX+4MZQCdpPJtlTDq4C7QK4JMKc72uihY/0pXg79omWiP7Zt
         wWScxx8uPs+RZuSoZ5Y18Gu7GuDviU0Gvu+fLwwTS4QnsuCKn5W0M3dlif606NfUtE5g
         dw2S9x/9XMtyRDiB8IIdQWhiDBLQPV8K1HcZaFO4pBePk2ZUp1ifj9fvw77RK6UM/+AX
         7tNTePWFSKi4OVZam6zbCap5VuamB6P8PtRBGxWfuFjYbMqxXoOciPf396Oh1p+Xxm16
         DrZ9Xx6pMa138pGm0zRXtBpXjfbBJT3YUeNNZDE3XJCOUU14ugM+ctFq29qOwXYC2/jB
         z49w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nate Watterson <nwatters@codeaurora.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 31/68] iommu/iova: Fix underflow bug in __alloc_and_insert_iova_range
Date: Mon, 19 Mar 2018 19:06:09 +0100
Message-Id: <20180319171832.134049442@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390563257454216?=
X-GMAIL-MSGID: =?utf-8?q?1595390563257454216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nate Watterson <nwatters@codeaurora.org>


[ Upstream commit 5016bdb796b3726eec043ca0ce3be981f712c756 ]

Normally, calling alloc_iova() using an iova_domain with insufficient
pfns remaining between start_pfn and dma_limit will fail and return a
NULL pointer. Unexpectedly, if such a "full" iova_domain contains an
iova with pfn_lo == 0, the alloc_iova() call will instead succeed and
return an iova containing invalid pfns.

This is caused by an underflow bug in __alloc_and_insert_iova_range()
that occurs after walking the "full" iova tree when the search ends
at the iova with pfn_lo == 0 and limit_pfn is then adjusted to be just
below that (-1). This (now huge) limit_pfn gives the impression that a
vast amount of space is available between it and start_pfn and thus
a new iova is allocated with the invalid pfn_hi value, 0xFFF.... .

To rememdy this, a check is introduced to ensure that adjustments to
limit_pfn will not underflow.

This issue has been observed in the wild, and is easily reproduced with
the following sample code.

	struct iova_domain *iovad = kzalloc(sizeof(*iovad), GFP_KERNEL);
	struct iova *rsvd_iova, *good_iova, *bad_iova;
	unsigned long limit_pfn = 3;
	unsigned long start_pfn = 1;
	unsigned long va_size = 2;

	init_iova_domain(iovad, SZ_4K, start_pfn, limit_pfn);
	rsvd_iova = reserve_iova(iovad, 0, 0);
	good_iova = alloc_iova(iovad, va_size, limit_pfn, true);
	bad_iova = alloc_iova(iovad, va_size, limit_pfn, true);

Prior to the patch, this yielded:
	*rsvd_iova == {0, 0}   /* Expected */
	*good_iova == {2, 3}   /* Expected */
	*bad_iova  == {-2, -1} /* Oh no... */

After the patch, bad_iova is NULL as expected since inadequate
space remains between limit_pfn and start_pfn after allocating
good_iova.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iova.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -118,7 +118,7 @@ static int __alloc_and_insert_iova_range
 				break;	/* found a free slot */
 		}
 adjust_limit_pfn:
-		limit_pfn = curr_iova->pfn_lo - 1;
+		limit_pfn = curr_iova->pfn_lo ? (curr_iova->pfn_lo - 1) : 0;
 move_left:
 		prev = curr;
 		curr = rb_prev(curr);
