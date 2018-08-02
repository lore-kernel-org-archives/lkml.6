Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0933AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD531208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GrbxX0pV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD531208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeHBIbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:31:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38362 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHBIbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:31:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w726dco6142457;
        Thu, 2 Aug 2018 06:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Ct68BS42SADlZjWpSg5LY8Gy/4XIVqDueAxV6cO7hkk=;
 b=GrbxX0pVnd63pBQlT0VmQkvj5hUPuKRaYjArW4JoN3bXrgorpaKC9GgsnQkAcxkSbNIG
 WSO4dHfSBgpM8Y4kd1cIQkyn1MrP5lK2vxwjKaiLNof2s3KnYs8eYbYPo9kXjk8qLe1H
 0cAyFpTQmUojWmndJRaVKYGt52n37z4C/eX8yjhCa+AqG79xzPzfwCXjdZ3umCC0hrKU
 ArMMPgowPWP2HTmG5bw9OFtTZLA5haz9wIp69ofEd9W82UFzYD3MJjAGwgEr5gMeHleI
 jnVNuurPEjuygAqrC4V8jgNFZgZHh+rNAgOtwBbqPhJq64oEZxDg0C4XjWN8VK01WAkJ uA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2kge0d9y98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Aug 2018 06:41:48 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w726fl1K030054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Aug 2018 06:41:47 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w726fkqC000966;
        Thu, 2 Aug 2018 06:41:46 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 23:41:46 -0700
Date:   Thu, 2 Aug 2018 09:41:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mikelley@microsoft.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com,
        kys@microsoft.com
Subject: Re: [PATCH char-misc 1/1] Drivers: hv: vmbus: Cleanup synic memory
 free path
Message-ID: <20180802064133.jm5wo4e5ypn6p3xq@mwanda>
References: <1533163513-10764-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533163513-10764-1-git-send-email-mikelley@microsoft.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8972 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808020072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 03:45:13PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mikelley@microsoft.com>
> 
> clk_evt memory is not being freed when the synic is shutdown
> or when there is an allocation error.  Add the appropriate
> kfree() call, along with a comment to clarify how the memory
> gets freed after an allocation error.  Make the free path
> consistent by removing checks for NULL since kfree() and
> free_page() already do the check.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/hv/hv.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 8d4fe0e..1fb9a6b 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -240,6 +240,10 @@ int hv_synic_alloc(void)
>  
>  	return 0;
>  err:
> +	/*
> +	 * Any memory allocations that succeeded will be freed when
> +	 * the caller cleans up by calling hv_synic_free()
> +	 */
>  	return -ENOMEM;
>  }
>  
> @@ -252,12 +256,10 @@ void hv_synic_free(void)
>         for_each_present_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu
>  			= per_cpu_ptr(hv_context.cpu_context, cpu);
>  
> -		if (hv_cpu->synic_event_page)
> -			free_page((unsigned long)hv_cpu->synic_event_page);
> -		if (hv_cpu->synic_message_page)
> -			free_page((unsigned long)hv_cpu->synic_message_page);
> -		if (hv_cpu->post_msg_page)
> -			free_page((unsigned long)hv_cpu->post_msg_page);
> +		kfree(hv_cpu->clk_evt);
> +		free_page((unsigned long)hv_cpu->synic_event_page);
> +		free_page((unsigned long)hv_cpu->synic_message_page);
> +		free_page((unsigned long)hv_cpu->post_msg_page);

This looks buggy.

We can pass NULLs to free_page() so that's fine.  So the error handling assumes
that hv_cpu->clk_evt is either NULL or allocated.  Here is how it is allocated:

   189  int hv_synic_alloc(void)
   190  {
   191          int cpu;
   192  
   193          hv_context.hv_numa_map = kcalloc(nr_node_ids, sizeof(struct cpumask),
   194                                           GFP_KERNEL);
   195          if (hv_context.hv_numa_map == NULL) {
   196                  pr_err("Unable to allocate NUMA map\n");
   197                  goto err;
   198          }
   199  
   200          for_each_present_cpu(cpu) {
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
We loop over each CPU.

   201                  struct hv_per_cpu_context *hv_cpu
   202                          = per_cpu_ptr(hv_context.cpu_context, cpu);
   203  
   204                  memset(hv_cpu, 0, sizeof(*hv_cpu));
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We set this cpu memory to NULL.

   205                  tasklet_init(&hv_cpu->msg_dpc,
   206                               vmbus_on_msg_dpc, (unsigned long) hv_cpu);
   207  
   208                  hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
   209                                            GFP_KERNEL);
   210                  if (hv_cpu->clk_evt == NULL) {
                            ^^^^^^^^^^^^^^^^^^^^^^^
Let's assume this fails on the first iteration through the loop.  We
haven't memset the next cpu to NULL or allocated it.  But we loop over
all the cpus in the error handling.  Since we didn't set everything to NULL in
hv_synic_free() then it seems like this could be a double free.  It's possible I
am misreading the code, but either it's buggy or the memset() can be removed.

This is a very typical bug for this style of error handling where we free
things which were never allocated.

   211                          pr_err("Unable to allocate clock event device\n");
   212                          goto err;
   213                  }

regards,
dan carpenter
