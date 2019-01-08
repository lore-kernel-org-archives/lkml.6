Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609DEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE5A2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nj2UeLgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfAHK0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:26:14 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:44742 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1546943173; x=1578479173;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Cx6QTekwHplcamMI2UeI4vrQ+fKtLM/lWi/oigLMMTk=;
  b=nj2UeLgqULnZYTEgTEWGzXqPQbJfzGlA8MbDhHmmNUOcXeMG/QB09abJ
   iNTdaSTdOZGgkxyDMqaI1JwctYdXfyalmpFt7joDmuwoia5ghDDfhO+2n
   WjiM0MOj2zoEtCn3YYsQeugFlyzCk4jRsqodXnRBmtCqRe2VbZYz7U4tT
   s=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="651998251"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jan 2019 10:26:10 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x08AQ4kk032477
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 8 Jan 2019 10:26:10 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 8 Jan 2019 10:26:09 +0000
Received: from [10.218.62.29] (10.43.160.173) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 8 Jan
 2019 10:26:02 +0000
Subject: Re: [PATCH] [v2]RDMA: add checks for the status of nla_put in
 ib_nl_send_msg
To:     Aditya Pakki <pakki001@umn.edu>
CC:     <kjlu@umn.edu>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190105170928.4086-1-pakki001@umn.edu>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <018c208a-9bcb-0c4c-7001-5447b06b1d84@amazon.com>
Date:   Tue, 8 Jan 2019 12:25:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190105170928.4086-1-pakki001@umn.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.173]
X-ClientProxiedBy: EX13D13UWA002.ant.amazon.com (10.43.160.172) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Jan-19 19:09, Aditya Pakki wrote:
>  
>  static int ib_nl_get_path_rec_attrs_len(ib_sa_comp_mask comp_mask)
> @@ -856,7 +873,10 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
>  	}
>  
>  	/* Add attributes */
> -	ib_nl_set_path_rec_attrs(skb, query);
> +	if (ib_nl_set_path_rec_attrs(skb, query, nlh)) {
> +		nlmsg_free(skb);
> +		return -EMSGSIZE;
> +	}

IMO, it's better to return the error code of ib_nl_set_path_rec_attrs instead of
an explicit -EMSGSIZE.
