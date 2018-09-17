Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EB7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C2D2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YoUjAhGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C2D2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeIQVWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:22:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42563 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIQVWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:22:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180917155424euoutp02a37897b4e4f7181def9ca08e5e38fb35~VOvMzAk9U0254702547euoutp02Z
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180917155424euoutp02a37897b4e4f7181def9ca08e5e38fb35~VOvMzAk9U0254702547euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537199664;
        bh=LhP3eKnymB4yWhXrC7/q4KtaP+Q7RAQKenfK1O4Zwrw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YoUjAhGorvIrayD/I+P0tKJRfxSKitCnAALWZM9M44fex/1xkWcekwnF/edQo1Ix4
         T0PVVnMNRc879FkA1t5qn3JPiZvdtDIws7hdlKfoKX7VUMR6yKhXtfPnrUrZZyOthG
         Bu9kAnQx8eMhWNRClo3IiZNqSWfHMBQvraxoYaIM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180917155423eucas1p2e93c0f3b64c6b5d7c59ca2c6ef8b3629~VOvMInfS-0418204182eucas1p2s;
        Mon, 17 Sep 2018 15:54:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1A.9C.04806.E2ECF9B5; Mon, 17
        Sep 2018 16:54:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180917155422eucas1p2ea33c73f046cb19c7be5fac7e9191059~VOvLUVLIR0418604186eucas1p2i;
        Mon, 17 Sep 2018 15:54:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180917155422eusmtrp1734f8a09ac9c7c5373e9a0c8837ca880~VOvLDYJUF1100711007eusmtrp1Q;
        Mon, 17 Sep 2018 15:54:22 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-f1-5b9fce2e70ca
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 14.FC.04284.E2ECF9B5; Mon, 17
        Sep 2018 16:54:22 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180917155421eusmtip1f73b8356bc7c1f18dc78aad9cb28a5b2~VOvKqlMJU0138101381eusmtip1Y;
        Mon, 17 Sep 2018 15:54:21 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] crypto: s5p-sss: Add aes-ctr support
To:     Christoph Manszewski <c.manszewski@samsung.com>,
        linux-crypto@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Date:   Mon, 17 Sep 2018 17:54:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c~VOImIjh2C1107511075eucas1p2w@eucas1p2.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87r65+ZHG3yPtNg4Yz2rxfHdSxkt
        5pxvYbHofiVjcf78BnaL+/d+Mllc3jWHzWLG+X1MFv9/NTM7cHpsWXmTyWPbAVWPTas62Tz+
        LZzC4tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZlx7/Zy1oFaz4N+k/awPjS94uRk4OCQET
        iQdrtjJ2MXJxCAmsYJR4+G4lK4TzhVHi6elmZgjnM6PE8YXbGGFa9m7YBJVYzijR17YOLCEk
        8JZR4uPiaBBbWMBB4nt/LwuILSIQLNH6+TQ7SAOzwDwmiZ6jN9lAEmwC5hKPtp9hArFZBFQl
        juxawg5iiwpESBx5sBBsKK+AoMTJmU/ABnEKlEu82jQbrJdZQFzi1pP5TBC2vMT2t3PALpIQ
        OMUu8e74ajaI5jKJVTffQZ3tIjFzz1F2CFtY4tXxLVC2jMTpyT0sEHa5xO6tz9ghBrUwSsyd
        vIgJImEtcfj4RWDIcABt05RYv0sfIuwosaqpAywsIcAnceOtIMQ9fBKTtk1nhgjzSnS0CUFU
        60rM+3+GFcKWluj6v451AqPSLCRfzkLy2Swkn81C2LuAkWUVo3hqaXFuemqxcV5quV5xYm5x
        aV66XnJ+7iZGYHI6/e/41x2M+/4kHWIU4GBU4uFdsGB+tBBrYllxZe4hRgkOZiURXmY+oBBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXFePq20aCGB9MSS1OzU1ILUIpgsEwenVANji4enWWxbb5jX
        3d8KKxPlLwvb9BT9vCDT6HCoUv3IsgVzmOdLfGG8XP3Rtlci+GPNro+mE8Ubcm7Naay4zreY
        xf53/oTl10NtLAwmOyd3T3M6+vjK+m/+7y5YXP3v4H0qYEVuuoqM3y12nbkMdx0mvte37V61
        dctiaX2Vp9+V9h+eM9HlTFSLEktxRqKhFnNRcSIA6r3rakoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7p65+ZHG3RMZrfYOGM9q8Xx3UsZ
        Leacb2Gx6H4lY3H+/AZ2i/v3fjJZXN41h81ixvl9TBb/fzUzO3B6bFl5k8lj2wFVj02rOtk8
        /i2cwuLRt2UVo8fnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2
        NimpOZllqUX6dgl6GZce/2ctaBWs+DfpP2sD40veLkZODgkBE4m9GzYxdzFycQgJLGWU2DD1
        IStEQlqi8fRqJghbWOLPtS42EFtI4DWjRP87LhBbWMBB4nt/LwuILSIQLPHgwQwWkEHMAvOY
        JA4eecMEMbWDSWLDzlNgVWwC5hKPtp8Bm8or4CZxfWUL2FQWAVWJI7uWsIPYogIREquXv2CF
        qBGUODnzCVgvp0C5xKtNs8HqmQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGoVlI2mchaZmF
        pGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNy27Gfm3cwXtoYfIhRgINRiYd3
        wYL50UKsiWXFlbmHGCU4mJVEeJn5gEK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0wWeSXx
        hqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGLtvsbSp1c8/FDQ9VOfE
        fA2eDeXr3jzZLWEWvsOkPijv+u3KRJVtPxfY3LFgunDO5WfET7P/MZFbVN/duac65ffqt2d3
        sF15wbNX29Dml5aGS2zq7p6Uuja5eM51jRwH3otcZrhSwqdTXMuvwHaN9cjNmUGFm549bVuw
        fsftC8f5bU8H/fHPy1BiKc5INNRiLipOBAB4hAno3gIAAA==
Message-Id: <20180917155422eucas1p2ea33c73f046cb19c7be5fac7e9191059~VOvLUVLIR0418604186eucas1p2i@eucas1p2.samsung.com>
X-CMS-MailID: 20180917155422eucas1p2ea33c73f046cb19c7be5fac7e9191059
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c
References: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c@eucas1p2.samsung.com>
        <20180917151011eucas1p274a1407a02081b49aa03da85cc9aec4c~VOImIjh2C1107511075eucas1p2w@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.09.2018 17:09, Christoph Manszewski wrote:
> Add support for aes counter(ctr) block cipher mode of operation for
> Exynos Hardware. In contrast to ecb and cbc modes, aes-ctr allows
> encyption/decryption for request sizes not being a multiple of 16(bytes).
> 
> Hardware requires block sizes being a multiple of 16(bytes). In order to
> achieve this, copy request source and destination memory, and align it's size
> to 16. That way hardware processes additional bytes, that are omitted
> when copying the result back to its original destination.
> 
> Tested on Odroid-U3 with Exynos 4412 CPU, kernel 4.19-rc2 with crypto
> run-time self test testmgr.
> 
> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/crypto/s5p-sss.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
> index ba8f2e2ea88f..0064be0e3941 100644
> --- a/drivers/crypto/s5p-sss.c
> +++ b/drivers/crypto/s5p-sss.c
> @@ -1813,7 +1813,7 @@ static struct ahash_alg algs_sha1_md5_sha256[] = {
>  };
>  
>  static void s5p_set_aes(struct s5p_aes_dev *dev,
> -			const u8 *key, const u8 *iv,
> +			const u8 *key, const u8 *iv, const u8 *ctr,
>  			unsigned int keylen)
>  {
>  	void __iomem *keystart;
> @@ -1821,6 +1821,9 @@ static void s5p_set_aes(struct s5p_aes_dev *dev,
>  	if (iv)
>  		memcpy_toio(dev->aes_ioaddr + SSS_REG_AES_IV_DATA(0), iv, 0x10);
>  
> +	if (ctr)
> +		memcpy_toio(dev->aes_ioaddr + SSS_REG_AES_CNT_DATA(0), ctr, 0x10);
> +
>  	if (keylen == AES_KEYSIZE_256)
>  		keystart = dev->aes_ioaddr + SSS_REG_AES_KEY_DATA(0);
>  	else if (keylen == AES_KEYSIZE_192)
> @@ -1902,8 +1905,9 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
>  	u32 aes_control;
>  	unsigned long flags;
>  	int err;
> -	u8 *iv;
> +	u8 *iv, *ctr;
>  
> +	/* This sets bit [13:12] to 00, which selects 128-bit counter */

s/bit/bits/

This this,

Acked-by: Kamil Konieczny <k.konieczny@partner.samsung.com>

Thanks!
Kamil
