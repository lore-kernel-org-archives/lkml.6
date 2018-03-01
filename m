Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967182AbeCAJpT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:45:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967086AbeCAJpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:45:14 -0500
Subject: Re: [PATCH v2] net: iucv: Free memory obtained by kzalloc
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jwi@linux.vnet.ibm.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
References: <1519881952-6663-1-git-send-email-arvind.yadav.cs@gmail.com>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 10:45:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519881952-6663-1-git-send-email-arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030109-0016-0000-0000-0000052B5EC3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030109-0017-0000-0000-000028686217
Message-Id: <8f90da04-d059-648a-0b45-e3a381e4342d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010128
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2018 06:25 AM, Arvind Yadav wrote:
> Free memory, if afiucv_iucv_init is not successful. So calling
> put_device() before kfree(). This will decrement the last reference.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>              Calling put_device() before kfree().
> 
>  net/iucv/af_iucv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 1e8cc7b..a07943f 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2433,9 +2433,12 @@ static int afiucv_iucv_init(void)
>  	af_iucv_dev->driver = &af_iucv_driver;
>  	err = device_register(af_iucv_dev);
>  	if (err)
> -		goto out_driver;
> +		goto out_iucv_dev;
>  	return 0;
> 
> +out_iucv_dev:
> +	put_device(af_iucv_dev);
> +	kfree(af_iucv_dev);
>  out_driver:
>  	driver_unregister(&af_iucv_driver);
>  out_iucv:
>

Just put_device() should be sufficient here; please get rid of the kfree() call.
 
