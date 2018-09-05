Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C832C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C5820652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cVl0b5A1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="R7TVsx1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C5820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIFBzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:55:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727257AbeIFBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:55:12 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85LKE2c032578;
        Wed, 5 Sep 2018 14:22:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=07Jisir+QEoGhdo3plYNZ2cFUavpnASyE6dY8M6D7ro=;
 b=cVl0b5A1OZmCQwV7hKcRsf5jXwMK2ZbuNEpD+/Q3mnMyHnHG46AziVgZpZ1jdrfOA7Uw
 9np+W9a9PRVJ6ijs361QxlR07fVhacjdnuFBT4slnpW+6Fnyzpm+b2cR8w/CciFbBLqz
 k+WEYSgHIBk5YBXDMlcqSg9FPxtOn/mNAeA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mamps8fbh-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Sep 2018 14:22:55 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 5 Sep 2018 14:22:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07Jisir+QEoGhdo3plYNZ2cFUavpnASyE6dY8M6D7ro=;
 b=R7TVsx1bqf9f5m9FxB42/l9RRjQSNcrGJdoil3nYGrX4S5F2ApIiBGQnt0F4+ImnNtB5JMQiaxUNrB55IinEgBkWgUBgbVMZJwZspef8xHkYzWF5+Kzd5Do+ybAcnB+aEjxz6v+tRNxKpY3VC6SVH39z6Z7RtdwTmpPx77BSNus=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::7:13) by
 CY1PR15MB0172.namprd15.prod.outlook.com (2a01:111:e400:58bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.13; Wed, 5 Sep
 2018 21:22:49 +0000
Date:   Wed, 5 Sep 2018 14:22:44 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Rik van Riel <riel@surriel.com>,
        Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] mm: slowly shrink slabs with a relatively small
 number of objects
Message-ID: <20180905212241.GA26422@tower.DHCP.thefacebook.com>
References: <20180904224707.10356-1-guro@fb.com>
 <20180905135152.1238c7103b2ecd6da206733c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180905135152.1238c7103b2ecd6da206733c@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::7:13]
X-ClientProxiedBy: MWHPR17CA0089.namprd17.prod.outlook.com
 (2603:10b6:300:c2::27) To CY1PR15MB0172.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4084bb65-63c1-4958-48d5-08d61375bbc6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0172;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;3:B252/PcPVF8XvocVxget5NoL8Lbwupc7SXfJtZQReCQ7ojaKPXyF+QN83dc7OuUGcynE/Q4qlcWgmnQSewmLvoMHz+DJe+a4TZLBZIoNk5OIJP57Jx6A7HNiATkLFOm2XkrvajPXEYurpKS6LsOsf0q26ZbE/cN94CGcK+M78WCP7wd0j16YPDB+VpmryNHMTuTjvjmJA+VVUZIuXE/VoJPM3DWfIdP3zCyUcg0hhQ8a4vIb4H7GdKJlNVCITDSQ;25:9WL9RfQYTuXpPgTR8QOdqTmDIhacNa8pwlPTUEMW13Hm1X532LlQvMkyNMmdzddIyU2b/191TBrIV2OJKOgcLyV5CLXdu6fjTf4q/kw/g5Xa0PD0LKce15DFDacpOdcqB/OY7RqgfRJdRJGyvq6OHmcUlGUHp445b1iP5UADxx/iy1dqAJqDBPX1ZCLoQwRhy+7/6lzcWue5Is7dNRe7E2DK669Ow6A3A9slOcRQIMV1GMGQP1kIdCYa6m2cFowarUy+YRq/2kLrUmjWkoGSzEoDOWCyA1PDl1DV/ng6bkUT7Ap/lBekfZ/vOF/r+h2gImiTu12Gdgtdu+zksxxnVg==;31:raEpLUhSAFgZ/Bkrpr1Hbg8RTf6o7jYeTxKe3evhl26ggttQsXg0I+l73AOn3jC2HvvJz/wugY6ujxZrLr9h2JGyvV8xzIPtKmTHh7dCVBleUDfol34nniTFpzhjX9VvoJWJ08COzLMlXcZ89gH3rTrc4GsddynFYk2AU5gIE0sviv1D5r6oLGYrVW4H6NVPRwx7fTKva9kk372EBSHJ4PpKnhfIaa3Kj6Ryh29vyaU=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0172:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;20:HxII9QZE/4lgrnij8OkraA2IrsXsau9DgM9xgZT8oahmEp9P3gimsPWuR9PTMDl4Wpodwq/iJhPYZKhKpTiHoYEQJ5+eXGCW6+Is+dIYtCM+EcGrvjJkhzWecqcIRDsNe9WMfDA8H+EHeVJUHayHtygjTfCE70ia8ZyXgXCgBeE1JdOHr9pzDpxF+OXJs5ykKGQBu5ndaiB85OIUsLZCDo+DG951pAmD7RDhXb+NrmA2j761+G6KNT6MFSpjp5NrszZ2Ih0Kno373LpS5SGudEW2JtwTsFAdGSxD+fu6wsPL+HP3lmFD7csAZGp5gS1Jf25bl9nfiwpfCA6Wkvk4R0Bh7YdXQNenfkJMxdOBAeha4djOWBc/ZurOYk9ny1hiKOKHoc2+RpKepuXNTwIzn+FV8gpZVNPICewSy3U9oovJ6lLieVcBlA4sy0/A4WwWn8cPfHoJZ8i8vI3EQwlG8gio0Gk9CcKveEb3lnQn0bitHrRzoBUukXBs4oSytxPq;4:Y6Ec7VgzU8xUXBB6YOmxBE/Yq5zVLW6j5lmWd3AB56+84bHSWSvS6gmv8T8N8u9d48YuZTb70JBfvAtk/NqJSZI0SGE6U8yfOlKbn5y3TWOX8k4huzPPrqCh3OU6tZgsooLkYq1U0jy2B2FN5SSar09Hi2I1j0tcXvLTi3N2QRcKp5z0Dcm03CTlplUoJ3Oks3B3P260gDGWtUZHi4Fo6KawAYA2dDkCSpKOHCGele88e4Id1Xl76GsYgjB698nyegN0xCvlx7+19RQ4SMo0e8xhQLkxvpaXW5HpUDVDKBZ1tm99jSyGGdlQAmz0XWAQ
X-Microsoft-Antispam-PRVS: <CY1PR15MB01727B7E4281DAC1F673FE56BE020@CY1PR15MB0172.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:CY1PR15MB0172;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0172;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(396003)(376002)(51444003)(189003)(199004)(6246003)(6116002)(7736002)(186003)(16526019)(478600001)(54906003)(8676002)(47776003)(7696005)(23726003)(50466002)(52396003)(229853002)(46003)(14444005)(305945005)(11346002)(446003)(476003)(76176011)(486006)(386003)(1076002)(6506007)(52116002)(2906002)(6916009)(86362001)(16586007)(9686003)(33656002)(53936002)(6666003)(68736007)(316002)(58126008)(55016002)(25786009)(105586002)(4326008)(81166006)(81156014)(106356001)(8936002)(5660300001)(97736004)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0172;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0172;23:Pn4Q3hOMODrOlMCae7DNDamdWod6TG8ySXsG3nclV?=
 =?us-ascii?Q?JZmVpDTaVQxr2jDwVMugl8z9jcY+bJMQQXgHKVRvl5Y7aA5zstEmKWgrA1I8?=
 =?us-ascii?Q?QhZd1jjLxHIup3vqpZunMKJXjJrwnEtOaBOQhQcNsX3nWEqQX9i/1B9xmS9T?=
 =?us-ascii?Q?IUKzN5bj9JiRRfykbv3sxkna28UYQH0EPNobN5QEDH31AqGIqFt02cWGeVD5?=
 =?us-ascii?Q?RJwTtgv34HzljRPL2BMTQnJemejdbe2PLZvLUIteL0Vz5Lr26ju/+UESKw/8?=
 =?us-ascii?Q?cuvM5UObghJq8zWYgd6CQmjL1L55Zzh26fEIf2I2htACQEg9MfmLEIroJLHo?=
 =?us-ascii?Q?wZ5K+kBsm5RZc20BNMsvBFIdhLEJbfG8E8inF5kMVgBNGe/YiyubKLBvYn+5?=
 =?us-ascii?Q?+PnT5KD/FgpCGeDEx4tlV5DHC6XJmGQHyVFuuj4O9CRpELdF7nS2hHdYA3ct?=
 =?us-ascii?Q?eL/n5OcZpMwXsl/Nxhj9jp36z/DeDkreDZUGXDcamrnejMmheB9lZtiqgPUP?=
 =?us-ascii?Q?qpNFls2Z2Om5hq2rJJV2Zt5c6HiQjzgJJNxfFatNd9MfaZIrQ1vPxeW7uQK4?=
 =?us-ascii?Q?7ZzhknEYUBRMkjtdELCzsRrncpDZrAWlMIDCCkHaNn5ZhTAlmE53FNxn+qFy?=
 =?us-ascii?Q?/PXs6/MopP9CTMhQeLAtnKYD5NzMO4dEXbDwElaBkzo1BwIFIDjYXu+OGK0W?=
 =?us-ascii?Q?teYuZqoOXa6lu8KfDGyklWU0tSKtNpHosfYLAVRcJW5atEDN+pltwdbusq3E?=
 =?us-ascii?Q?oU0shaoCvH4HNvw+4HmE9BBB4no1wq6JITBIxt45R/fkhyuulAh9T4vvBeuV?=
 =?us-ascii?Q?kYrOEdTU44mBE2Q5FGMo20ayXZkuJLv4cNkiz90NbyXEyXlEe4j5nEvLFzYZ?=
 =?us-ascii?Q?xAI53DzVMouNQ+C1oTvLRdmRBK/yN9+eNbFTP7Q+Q/Ye/TNDHd0yveorE4Zm?=
 =?us-ascii?Q?3cUkEUS5JN/wjYFqAVMZHRKSekAHytsQcnsJjsDDtULYWGvDWsEuJOzGXzO1?=
 =?us-ascii?Q?On//L5rCzKySH+qlfbKC/uDyEMbCfcHKNUzf4oGFFCNsG6uWbPBHTpPHH+P+?=
 =?us-ascii?Q?RM3feRB4TPISU09zYFXNOSaI++kOFiwQQTBpzVn3OlHiwPPwhYNA0SXipN3p?=
 =?us-ascii?Q?z+BaR0XUKEmQKgZeXkGS6nuVTo8aAlhjrb5b0AeaJnkm3iTcl8zxOVfEUZoO?=
 =?us-ascii?Q?Vdfnhw11uIxudepYlptv0MNS9G4eBhqr68ZjyobE+X5HAHPgwUip3s12bSfk?=
 =?us-ascii?Q?IQmQ1pDydyD3KBpYaeQljr5jfr+/PrQQ/j+GAPweXsOItBeE4p0+QI+ItjjY?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: 5kwS8afoGOPTYG3kjmv+CTqsk3IZijyxvTypQqVcNcNCDGPKmGQrEQnyjNLoJsHv7/ZBSyMjF08jxiTbVjnKTtowueK9G2ut4QV8QRBFhzFxm2NkNFy0Vj6IS/B3qlQh9sTheln20q/1/Rm1H1f0R2H7bgUokzUfrI6bIIyUPhNNN7+ZUffovldBOe5VKXzN7tPw6zJBVxh5s0RmuRg+pYm4JvQZ7OdpCy2xHJka6KECDR9SO/l/QdfE5PKVzEpTp8L1zgWorxJd/ExB8MAacyeZn/aeYuOtJrX1IrFwig+l09tM10Ei62xPDuYEeVVOZJx+eRPQz1G4Y6HXjKmA7w46wzMX97vidtJKzdcGcu0=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;6:sBD1mX5lbLsg0Vp5D6hgsU0/RV/0yjUFylMHFzrtP9A6Q5zsyyU+9FlX0qd+EeJksICfajDmq5Bwr+rQ4jR5qw4ZtRiTVTLIMjM1q/sAX+iN8uXM+7i3AboK5lgvrc7CmmQxoc/PFzrrqA107/0mPW6JJSHCLq/VDOIqbuUc3nE+QxIWeOLuf/5KicsIPpTD8KPlX1+nBhQrQP3s3WEE/f3XGhOh4F7GqSKR5orQOR6VPblTLzB45mX35Htu4ivvOUZ9nkDrZwcxUJkCc6kv0e72cOBZWb5EosekiQbNRUhdK03beuolwY6NV6AdhPOBj+UL1BxPbj3tNvtfQDdL2TKl+JPss19HEbfbSUNxZt2dRNwJZ9dzoMXbq1HPbOCp8JxZZ70w7BWgb4CzJZXczzz3GXg6ijrb8jdQHiJk/EvmzZY3OZSN4Kfa8XNH+brDtNOvlEyWTQ2u8KfTOUI9QQ==;5:IuWov961b7+3fxz56jrbgztFDFi5oiNRA7chWUAjfzRs0WMcvEUyocb1H+1fyuKh+9uBeC5ilQ9fV7WAHyofTOcXjrX19O2xeah7ikYwyai5rl9FwPOqLtfrOfXq19rSJcd7yK5NUomdDvlY1kJPLvOwez46g2rngut4ftkNv3k=;7:hY9sGouNRWrXoVlZ7zvOqAzk8COQ17VkZ4TtmSqgTwL8m3m/WKMxv2zwIack3fPO7V5R7OEyde4no/Nagav9jICfSvcKI2BpRBm8hbPfORhjYvru+syvO+dQlJ/AgdsI/WGbAZMOoF9zJk/yfejVscNOvTsGf3faCYfkVbk9p178NWsZXxYTd7BbX5BGu5H7DIiRT5lB0pewC+OwbuHbij8F1PJNgocGRFX4AIYQmpkhIIv83MnvX97ShDC+GzHF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;20:fgKAWKZUw14ygpHl1LA8WAGC4Bl6Z3zbW95/Onj8bNDQsJzsXJ1LulIbOloGR+nWknEWIqDudl9Ugul8mt6K8RuN5Vh8PS1UfOPGjt8UnkTimq5P6gVqi3OebkdQHXC18lHltEs3LypVa3P3fQ2K0vgyBfbiB3T5A5BosCBxnLQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 21:22:49.7025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4084bb65-63c1-4958-48d5-08d61375bbc6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0172
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 01:51:52PM -0700, Andrew Morton wrote:
> On Tue, 4 Sep 2018 15:47:07 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > Commit 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
> > changed the way how the target slab pressure is calculated and
> > made it priority-based:
> > 
> >     delta = freeable >> priority;
> >     delta *= 4;
> >     do_div(delta, shrinker->seeks);
> > 
> > The problem is that on a default priority (which is 12) no pressure
> > is applied at all, if the number of potentially reclaimable objects
> > is less than 4096 (1<<12).
> > 
> > This causes the last objects on slab caches of no longer used cgroups
> > to never get reclaimed, resulting in dead cgroups staying around forever.
> 
> But this problem pertains to all types of objects, not just the cgroup
> cache, yes?

Well, of course, but there is a dramatic difference in size.

Most of these objects are taking few hundreds bytes (or less),
while a memcg can take few hundred kilobytes on a modern multi-CPU
machine. Mostly due to per-cpu stats and events counters.

> 
> > Slab LRU lists are reparented on memcg offlining, but corresponding
> > objects are still holding a reference to the dying cgroup.
> > If we don't scan them at all, the dying cgroup can't go away.
> > Most likely, the parent cgroup hasn't any directly associated objects,
> > only remaining objects from dying children cgroups. So it can easily
> > hold a reference to hundreds of dying cgroups.
> > 
> > If there are no big spikes in memory pressure, and new memory cgroups
> > are created and destroyed periodically, this causes the number of
> > dying cgroups grow steadily, causing a slow-ish and hard-to-detect
> > memory "leak". It's not a real leak, as the memory can be eventually
> > reclaimed, but it could not happen in a real life at all. I've seen
> > hosts with a steadily climbing number of dying cgroups, which doesn't
> > show any signs of a decline in months, despite the host is loaded
> > with a production workload.
> > 
> > It is an obvious waste of memory, and to prevent it, let's apply
> > a minimal pressure even on small shrinker lists. E.g. if there are
> > freeable objects, let's scan at least min(freeable, scan_batch)
> > objects.
> > 
> > This fix significantly improves a chance of a dying cgroup to be
> > reclaimed, and together with some previous patches stops the steady
> > growth of the dying cgroups number on some of our hosts.
> > 
> > ...
> >
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -476,6 +476,17 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  	delta = freeable >> priority;
> >  	delta *= 4;
> >  	do_div(delta, shrinker->seeks);
> > +
> > +	/*
> > +	 * Make sure we apply some minimal pressure even on
> > +	 * small cgroups. This is necessary because some of
> > +	 * belonging objects can hold a reference to a dying
> > +	 * child cgroup. If we don't scan them, the dying
> > +	 * cgroup can't go away unless the memory pressure
> > +	 * (and the scanning priority) raise significantly.
> > +	 */
> > +	delta = max(delta, min(freeable, batch_size));
> > +
> 
> If so I think the comment should be cast in more general terms.  Maybe
> with a final sentence "the cgroup cache is one such case".

So, I think that we have to leave explicitly explained memcg refcounting
case, but I'll add a line about other cases as well.

> 
> Also, please use all 80 columns in block comments to save a few display
> lines.
> 
> And `delta' has type ULL whereas the other two are longs.  We'll
> presumably hit warnings here, preventable with max_t.
>

Let me fix this in v3.

Thank you!
