Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B6CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761B4265C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c5dfvC35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761B4265C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932723AbeF0Ifq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:35:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48308 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbeF0Ifo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:35:44 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5R8Y5GP072590;
        Wed, 27 Jun 2018 08:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=467m1YLn2GdNBGtcMM16jJt+H1W3y581rFvlQMDngAg=;
 b=c5dfvC354rfwLIiZ/aUkw6UNVCACpHTXglUpGrlEz8JAXT6iWOpLy+9C4rdvdwWAs7Uk
 +8xBzo1FBMhmik6lthjYYSvQEcA8Nwr4CKzYgLElaB2Bf8dzaK7jS+lne71Sv8y0z9yy
 AQxJEo3qZTK0TPyIgkKzvBwf3Gq7s1aSL3a+vDYHbUttuC88PyhNzGWZ0VAS01oZytKu
 RhW8x1iiJ5w3nmSiq04/vk2/ceUDlnjR3vT5M2L/+NBJJk1Dpj9ziTSmZqOzQNpsXYqI
 hPlPXn+9nhS/54/S7fTnz+wRwGO/SSfZI2pK9IBYzSF1XD35SPBDR7L48AxEp4kgoKle WQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jukmtuuru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 08:35:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5R8Z0wF003747
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 08:35:00 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5R8Yxj4020034;
        Wed, 27 Jun 2018 08:34:59 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 01:34:58 -0700
Date:   Wed, 27 Jun 2018 11:34:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     kbuild@01.org, kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] drivers/base: reorder consumer and its children
 behind suppliers
Message-ID: <20180627083445.jsu2ffyz5cl4wbjn@mwanda>
References: <1529904187-18673-3-git-send-email-kernelfans@gmail.com>
 <20180626074426.hzunfbvwbubt3t3p@mwanda>
 <CAFgQCTsCFP_6znUaFKnczuUJjMMA1Hq_Qrk6CUVs+EFEBZgTMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTsCFP_6znUaFKnczuUJjMMA1Hq_Qrk6CUVs+EFEBZgTMQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=364
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806270101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:34:54AM +0800, Pingfan Liu wrote:
> > 1b2a1e63 Pingfan Liu 2018-06-25  243            }
> > 1b2a1e63 Pingfan Liu 2018-06-25  244    }
> > 1b2a1e63 Pingfan Liu 2018-06-25 @245    BUG_ON(!ret);
> >
> > If the list is empty then "ret" can be unitialized.  We test a different
> > list "dev->links.suppliers" to see if that's empty.  I wrote a bunch of
> > code to make Smatch try to understand about empty lists, but I don't
> > think it works...
> >
> Yes, if list_empty, then the code can not touch ret. But ret is
> useless in this scene. Does it matter?
> 

I'm not sure I understand what you're asking?  Of course, it matters?

regards,
dan carpenter


