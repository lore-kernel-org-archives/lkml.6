Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id v3EdFyQ3HlvCIwAAmS7hNA
	; Mon, 11 Jun 2018 08:48:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CAECC60792; Mon, 11 Jun 2018 08:48:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 10C81602FC;
	Mon, 11 Jun 2018 08:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10C81602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeFKIsT convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 20 others);
        Mon, 11 Jun 2018 04:48:19 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:38403 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754024AbeFKIsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:48:17 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 1EA03431565E8;
        Mon, 11 Jun 2018 16:48:14 +0800 (CST)
Received: from DGGEML511-MBX.china.huawei.com ([169.254.1.61]) by
 DGGEML404-HUB.china.huawei.com ([fe80::b177:a243:7a69:5ab8%31]) with mapi id
 14.03.0382.000; Mon, 11 Jun 2018 16:48:08 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Farhan Ali <alifm@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "mst@redhat.com" <mst@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        longpeng <longpeng2@huawei.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>
Subject: RE: [RFC v1 2/2] crypto/virtio-crypto: Register an algo only if
 it's supported
Thread-Topic: [RFC v1 2/2] crypto/virtio-crypto: Register an algo only if
 it's supported
Thread-Index: AQHT/1w9irxqESt7g0CZ2KZ6/sbWPKRawPbg
Date: Mon, 11 Jun 2018 08:48:07 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB015ABF@dggeml511-mbx.china.huawei.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
 <a9a06d82df69387bf1e66975b520d9049e9976e8.1528462918.git.alifm@linux.ibm.com>
In-Reply-To: <a9a06d82df69387bf1e66975b520d9049e9976e8.1528462918.git.alifm@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.18.62]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Farhan Ali [mailto:alifm@linux.ibm.com]
> Sent: Saturday, June 09, 2018 3:09 AM
> To: linux-kernel@vger.kernel.org; kvm@vger.kernel.org
> Cc: mst@redhat.com; qemu-devel@nongnu.org; Gonglei (Arei)
> <arei.gonglei@huawei.com>; longpeng <longpeng2@huawei.com>;
> pasic@linux.ibm.com; frankja@linux.ibm.com; borntraeger@de.ibm.com;
> alifm@linux.ibm.com
> Subject: [RFC v1 2/2] crypto/virtio-crypto: Register an algo only if it's supported
> 
> From: Farhan Ali <alifm@linux.vnet.ibm.com>
> 
> Register a crypto algo with the Linux crypto layer only if
> the algorithm is supported by the backend virtio-crypto
> device.
> 
> Also route crypto requests to a virtio-crypto
> device, only if it can support the requested service and
> algorithm.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_algs.c   | 110
> ++++++++++++++++++---------
>  drivers/crypto/virtio/virtio_crypto_common.h |  11 ++-
>  drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 ++++++++++++++++++--
>  3 files changed, 158 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c
> b/drivers/crypto/virtio/virtio_crypto_algs.c
> index ba190cf..fef112a 100644
> --- a/drivers/crypto/virtio/virtio_crypto_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_algs.c
> @@ -49,12 +49,18 @@ struct virtio_crypto_sym_request {
>  	bool encrypt;
>  };
> 
> +struct virtio_crypto_algo {
> +	uint32_t algonum;
> +	uint32_t service;
> +	unsigned int active_devs;
> +	struct crypto_alg algo;
> +};
> +
>  /*
>   * The algs_lock protects the below global virtio_crypto_active_devs
>   * and crypto algorithms registion.
>   */
>  static DEFINE_MUTEX(algs_lock);
> -static unsigned int virtio_crypto_active_devs;
>  static void virtio_crypto_ablkcipher_finalize_req(
>  	struct virtio_crypto_sym_request *vc_sym_req,
>  	struct ablkcipher_request *req,
> @@ -312,13 +318,19 @@ static int virtio_crypto_ablkcipher_setkey(struct
> crypto_ablkcipher *tfm,
>  					 unsigned int keylen)
>  {
>  	struct virtio_crypto_ablkcipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
> +	uint32_t alg;
>  	int ret;
> 
> +	ret = virtio_crypto_alg_validate_key(keylen, &alg);
> +	if (ret)
> +		return ret;
> +
>  	if (!ctx->vcrypto) {
>  		/* New key */
>  		int node = virtio_crypto_get_current_node();
>  		struct virtio_crypto *vcrypto =
> -				      virtcrypto_get_dev_node(node);
> +				      virtcrypto_get_dev_node(node,
> +				      VIRTIO_CRYPTO_SERVICE_CIPHER, alg);
>  		if (!vcrypto) {
>  			pr_err("virtio_crypto: Could not find a virtio device in the
> system\n");

We'd better change the above error message now. What about:
 " virtio_crypto: Could not find a virtio device in the system or unsupported algo" ?

Regards,
-Gonglei
