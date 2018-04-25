Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbeDYPov (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:44:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47504 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754820AbeDYPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:44:46 -0400
Subject: Re: [PATCH] sparc: vio: use put_device() instead of kfree()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, davem@davemloft.net,
        jag.raman@oracle.com, liam.merwick@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <a3722bda2eadf1ff229f73da6f0316f954956ae1.1524668025.git.arvind.yadav.cs@gmail.com>
From: Shannon Nelson <shannon.nelson@oracle.com>
Organization: Oracle Corporation
Message-ID: <d16d5b54-90c9-3137-bc74-2b0d7135a928@oracle.com>
Date: Wed, 25 Apr 2018 08:44:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a3722bda2eadf1ff229f73da6f0316f954956ae1.1524668025.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804250146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/2018 7:56 AM, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error. Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   arch/sparc/kernel/vio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
> index 1a0fa10..32bae68 100644
> --- a/arch/sparc/kernel/vio.c
> +++ b/arch/sparc/kernel/vio.c
> @@ -403,7 +403,7 @@ static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
>   	if (err) {
>   		printk(KERN_ERR "VIO: Could not register device %s, err=%d\n",
>   		       dev_name(&vdev->dev), err);
> -		kfree(vdev);
> +		put_device(&vdev->dev);

Hmmm... I can see why the put_device() might be a good idea, but I think 
we still need the kfree() so as to not leak the memory that was 
kzalloc'd above for vdev.

sln

>   		return NULL;
>   	}
>   	if (vdev->dp)
> 
