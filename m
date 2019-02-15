Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27032C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FA1222DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T9LLe0N3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389249AbfBOHGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:06:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53688 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731616AbfBOHGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:06:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1F74TDP164108;
        Fri, 15 Feb 2019 07:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3SscrwQqZcA7816MjTG69R7qXPpXX62z9mrpBnKhVVU=;
 b=T9LLe0N31warulPvZ6rjpJV/2PW1KG9DhivXeMSId9MK9ZQfUhghVlvFufNIPkBpcQpN
 7FbkdHsbeaEypQz/2M9JxVtTovrHHuPWgIs5jkxjZg64f7vaxVhcZEVF3V/S9c3H9aoN
 IsNvViOQLv1gICOBOK0fum3SCO4co9Ngtm7lLDweAM0QAb8skbbEIA4YiIaW8NVD0EeN
 pqInRT7MuvKZsOcvt24xxQrrrecIx0QCVgsdAKRtjOZAjZ8kJGHy9DIgRIPB8SqR/p2i
 /g+VwIU+KkoMxDwwE89fppvHjXZ6levo/1J/hfRw+4HfDRDQdH7b0ekVAkhlVpmXx1N+ Pw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qhre5v3eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 07:06:26 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1F76PEX028579
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 07:06:26 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1F76NJh029066;
        Fri, 15 Feb 2019 07:06:24 GMT
Received: from kadam (/197.157.0.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 23:06:23 -0800
Date:   Fri, 15 Feb 2019 10:06:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging/android: use multiple futex wait queues
Message-ID: <20190215070614.GC2326@kadam>
References: <20190214173459.GA10737@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214173459.GA10737@behemoth.owl.eu.com.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=844 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 06:34:59PM +0100, Hugo Lefeuvre wrote:
> @@ -402,6 +410,7 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
>  	struct vsoc_region_data *data = vsoc_dev.regions_data + region_number;
>  	int ret = 0;
>  	struct vsoc_device_region *region_p = vsoc_region_from_filep(filp);
> +	struct vsoc_futex_wait_queue_t *it, *wait_queue = NULL;
                                             ^^^^^^^^^^^^^^^^^
>  	atomic_t *address = NULL;
>  	ktime_t wake_time;
>  
> @@ -415,10 +424,27 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
>  	address = shm_off_to_virtual_addr(region_p->region_begin_offset +
>  					  arg->offset);
>  
> +	/* Find wait queue corresponding to offset or create it */
> +	spin_lock(&data->futex_wait_queue_lock);
> +	list_for_each_entry(it, &data->futex_wait_queue_list, list) {
> +		if (wait_queue->offset == arg->offset) {
                    ^^^^^^^^^^^^^^^^^^
You meant "it->offset".


> +			wait_queue = it;
> +			break;
> +		}
> +	}
> +
> +	if (!wait_queue) {
> +		wait_queue = kmalloc(sizeof(*wait_queue), GFP_KERNEL);
> +		wait_queue->offset = arg->offset;
> +		init_waitqueue_head(&wait_queue->queue);
> +		list_add(&wait_queue->list, &data->futex_wait_queue_list);
> +	}
> +	spin_unlock(&data->futex_wait_queue_lock);

regards,
dan carpenter
