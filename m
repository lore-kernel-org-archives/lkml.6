Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECC8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC57D208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC57D208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeH0Qvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:51:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbeH0Qvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:51:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7RD4uvu116613
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 09:05:01 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m4gj4ues2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 09:05:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 27 Aug 2018 14:04:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Aug 2018 14:04:50 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7RD4nNW41353312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Aug 2018 13:04:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27F6C5204F;
        Mon, 27 Aug 2018 16:04:47 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.97])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 97E6A52078;
        Mon, 27 Aug 2018 16:04:45 +0100 (BST)
Date:   Mon, 27 Aug 2018 16:04:46 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] clk: pmc-atom: use devm_kstrdup_const()
References: <20180827082101.5036-1-brgl@bgdev.pl>
 <20180827082101.5036-2-brgl@bgdev.pl>
 <20180827103915.GC13848@rapoport-lnx>
 <CAMRc=MeCRw459ppuVK=w53C2eHOVVHPksF_4hx_dY1J-3fgPsQ@mail.gmail.com>
 <20180827125226.GD13848@rapoport-lnx>
 <CAMRc=MchWQEiH82KYdXvPWzJ6U9YLLJ8425M3Jct1O0EMZpokA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MchWQEiH82KYdXvPWzJ6U9YLLJ8425M3Jct1O0EMZpokA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18082713-0028-0000-0000-000002F0482A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082713-0029-0000-0000-000023A99BA3
Message-Id: <20180827130446.GE13848@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808270140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 02:58:46PM +0200, Bartosz Golaszewski wrote:
> 2018-08-27 14:52 GMT+02:00 Mike Rapoport <rppt@linux.vnet.ibm.com>:
> > On Mon, Aug 27, 2018 at 02:28:45PM +0200, Bartosz Golaszewski wrote:
> >> 2018-08-27 12:39 GMT+02:00 Mike Rapoport <rppt@linux.vnet.ibm.com>:
> >> > On Mon, Aug 27, 2018 at 10:21:01AM +0200, Bartosz Golaszewski wrote:
> >> >> Use devm_kstrdup_const() in the pmc-atom driver. This mostly serves as
> >> >> an example of how to use this new routine to shrink driver code.
> >> >>
> >> >> While we're at it: replace a call to kcalloc() with devm_kcalloc().
> >> >>
> >> >> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> >> >> ---
> >> >>  drivers/clk/x86/clk-pmc-atom.c | 19 ++++---------------
> >> >>  1 file changed, 4 insertions(+), 15 deletions(-)
> >> >>
> >> >> diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
> >> >> index 08ef69945ffb..daa2192e6568 100644
> >> >> --- a/drivers/clk/x86/clk-pmc-atom.c
> >> >> +++ b/drivers/clk/x86/clk-pmc-atom.c
> >> >> @@ -253,14 +253,6 @@ static void plt_clk_unregister_fixed_rate_loop(struct clk_plt_data *data,
> >> >>               plt_clk_unregister_fixed_rate(data->parents[i]);
> >> >>  }
> >> >>
> >> >> -static void plt_clk_free_parent_names_loop(const char **parent_names,
> >> >> -                                        unsigned int i)
> >> >> -{
> >> >> -     while (i--)
> >> >> -             kfree_const(parent_names[i]);
> >> >> -     kfree(parent_names);
> >> >> -}
> >> >> -
> >> >>  static void plt_clk_unregister_loop(struct clk_plt_data *data,
> >> >>                                   unsigned int i)
> >> >>  {
> >> >> @@ -286,8 +278,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
> >> >>       if (!data->parents)
> >> >>               return ERR_PTR(-ENOMEM);
> >> >>
> >> >> -     parent_names = kcalloc(nparents, sizeof(*parent_names),
> >> >> -                            GFP_KERNEL);
> >> >> +     parent_names = devm_kcalloc(&pdev->dev, nparents,
> >> >> +                                 sizeof(*parent_names), GFP_KERNEL);
> >> >>       if (!parent_names)
> >> >>               return ERR_PTR(-ENOMEM);
> >> >>
> >> >> @@ -300,7 +292,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
> >> >>                       err = PTR_ERR(data->parents[i]);
> >> >>                       goto err_unreg;
> >> >>               }
> >> >> -             parent_names[i] = kstrdup_const(clks[i].name, GFP_KERNEL);
> >> >> +             parent_names[i] = devm_kstrdup_const(&pdev->dev,
> >> >> +                                                  clks[i].name, GFP_KERNEL);
> >> >>       }
> >> >>
> >> >>       data->nparents = nparents;
> >> >> @@ -308,7 +301,6 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
> >> >>
> >> >>  err_unreg:
> >> >>       plt_clk_unregister_fixed_rate_loop(data, i);
> >> >> -     plt_clk_free_parent_names_loop(parent_names, i);
> >> >
> >> > What happens if clks[i].name is not a part of RO data? The devm_kstrdup_const
> >> > will allocate memory and nothing will ever free it...
> >> >
> >>
> >> I'm looking at it and trying to see if I'm missing something, but
> >> AFAIK the whole concept of devm_* is to leave out the resource
> >> management part.
> >>
> >> devm_kstrdup_const() will internally call devm_kstrdup() for strings
> >> that are not in .rodata and once the device is detached, the string
> >> will be freed (or not if it's in .rodata).
> >
> > And when it's going to be freed, how the resource management will know
> > whether it's .rodata or not?
> >
> 
> If the string to be duplicated is in .rodata, it's returned as is from
> devm_kstrdup_const(). Never gets added to the devres list, never get's
> freed. When the string to be duplicated is not in .rodata,
> devm_kstrdup() is called from devm_kstrdup_const(). Now the string is
> in the devres list of this device and it will get freed on driver
> detach. I really don't see what else could be a problem here.

Thanks for the clarification.
I think that it's worth adding a similar explanation to the changelog of
the first patch.
 
> BR
> Bart
> 
> >> BR
> >> Bart
> >>
> >> > And, please don't drop kfree(parent_names) here.
> >> >
> >> >>       return ERR_PTR(err);
> >> >>  }
> >> >>
> >> >> @@ -351,15 +343,12 @@ static int plt_clk_probe(struct platform_device *pdev)
> >> >>               goto err_unreg_clk_plt;
> >> >>       }
> >> >>
> >> >> -     plt_clk_free_parent_names_loop(parent_names, data->nparents);
> >> >> -
> >> >>       platform_set_drvdata(pdev, data);
> >> >>       return 0;
> >> >>
> >> >>  err_unreg_clk_plt:
> >> >>       plt_clk_unregister_loop(data, i);
> >> >>       plt_clk_unregister_parents(data);
> >> >> -     plt_clk_free_parent_names_loop(parent_names, data->nparents);
> >> >
> >> > Ditto.
> >> >
> >> >>       return err;
> >> >>  }
> >> >>
> >> >> --
> >> >> 2.18.0
> >> >>
> >> >
> >> > --
> >> > Sincerely yours,
> >> > Mike.
> >> >
> >>
> >
> > --
> > Sincerely yours,
> > Mike.
> >
> 

-- 
Sincerely yours,
Mike.

