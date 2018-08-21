Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1240DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3065217BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="DRywrjRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3065217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeHUUVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:21:35 -0400
Received: from mail-by2nam03on0104.outbound.protection.outlook.com ([104.47.42.104]:62696
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbeHUUVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll6G8cTuUbXvwEfrrWg5ESC84XqEA1sT9OfCS08TuTI=;
 b=DRywrjRfwq84EHmZGJkNMMuo88aoF8IW/jJEWtRTpgXhW3Oc6I874vf7srHGORAWsyCD+td8Vm/LpOgB/KX+XnPUjkDbG0fzWt7RVDNEB9b49LeThPEmOCEPgZTj1JdTZJx2Ev0XGqzGMwCMw22cAseJFyRYasUK0NrwprAGztk=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Tue, 21 Aug 2018 17:00:36 +0000
Date:   Tue, 21 Aug 2018 10:00:34 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v9 1/2] kbuild: Allow arch-specific asm/compiler.h
Message-ID: <20180821170034.rpnwukgnpyrpxytw@pburton-laptop>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop>
 <20180820223618.22319-1-paul.burton@mips.com>
 <20180820223618.22319-2-paul.burton@mips.com>
 <CAK7LNASarMBH8af=oTPoanEvJOS3zWTKx4MpGZe-AJiP2Wu41g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASarMBH8af=oTPoanEvJOS3zWTKx4MpGZe-AJiP2Wu41g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0047.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::33) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a3e2e5c-c1ab-41e5-4bf4-08d607879d9e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:RtDn1R/cQZi0RrrNFuflmiH5eubo8Liipz0sQ2bA7MWDRGEmLoMaAl8zoWz+hTmtq6lEge5ZRjNsF5n1E41aqlGR3fJjBOSVU0mW0xFiE9o4xXHt87nL5WRrSgvi11Nydjmj1w6gI52bC3n370kk8uYNvrW/F4ChQPCaichP5vtsTkYj+hhTnI+NzDmFgD4Z1B+0hQ2ST+1SCHLMX2GyySiBkCWPsMBaHNG90OstjoxWlOFwuXIG92SwqyT28sZs;25:bTD7m298JgWOA9jFxhZzo4aDh+CrFxgyG2RQbCQS5dypGskFsEaq2s/0BnJ13um91nmtbX/74u1JK/iuZX8tRBwKIfeh9RYLRfGIm006gfOw99zDpInMiqyOcb6LcH8bx/vP85+0a2vs654Lq/GJ2sgt2JzHRqmSAUf0ah0qgtuzAJocHTtIWvzmIdB/qOyBwoPJNNoUj8oYMzusV8T2+uu6xS63FAISY3RoCsnGYdtDs0460JsKQodgvxWLcxYZgQbMOmfHA1jBtAZzNhwcSrAp59T61SSn+DOsyL/NcrQ1lLBjfTHhLOf96RhJibZui8sbkSRvF/IQfqirFSY9PA==;31:gQQN8mUYqXRx5fjNMuFF1t7GbSzt7YZJifWBEAQ7SrxnrsP9pgp0T7YqVT3DpEZOJ0yA8k+weo/BX3IsfucS6eqZI7DKN+OXH/swO6SrqMcdTKPgRYo7mkU5GNNP4uVUok6+U0Yz02izHOjyPBlHCKvAct7XqndIbVsg+TFG2s3/oMNDiGtPv0+tVm8JU7pyiOf5rSzA/L1zEqfb/esa5qMkXRDjoJI0CDNmjPJB7N4=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:clBXDjuno3GipeF4PLzEmEtu9jyUIoowmAKx8VtTWIiSRLZ4qQX7itI/vZyYyMNmdNbpTkV3F/x86amsgwgd1yURor7iTBL7QJNrTMP2MmirTs9VaJxPlpcbLo26kbufmNrI+X0AsLnA9mZD+rYgkNkplwbGtQibZzAVVdQxFfRCZ3InrrIcpKKO1q2qyHlz265HCGaV3dgzdJPQK0ruh1jdH+Fh9UYhO5Ni8lJCHtJUYcrwq11PwXOuI0eptGnD;4:gXmEikALSOqjEjbZRcvAwuIWjILsOIIsACC49c9oZUEIFey0Jc7yRI/zyCpZPEHrw+qYxnJNx7t8Idagfy621qbiB8r7WCDBYyBNMx8Nyzbw+zPJzaCqZaiCtJuJpwt2n10Rt+QTFrzzZamxhHlhmgO5PHKQrT45LXMz95k9ipa9VK5gIgEYHIjQhuKkRSbW7u0ZzGMFijOjGx/sT91ouM5RgYUNXquxq6tm3++pWyVGaxePkhvANaA/OAIIU/M45CI9MVoAcKGEd6xuqkAP8w==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4933D8AF9E9D49847ABC12B5C1310@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(396003)(346002)(39840400004)(136003)(199004)(189003)(23726003)(9686003)(76506005)(2906002)(81166006)(4326008)(6486002)(229853002)(25786009)(50466002)(53936002)(7736002)(5660300001)(68736007)(8676002)(81156014)(44832011)(8936002)(106356001)(6246003)(6916009)(105586002)(33716001)(93886005)(1076002)(476003)(52116002)(3716004)(446003)(6496006)(54906003)(33896004)(97736004)(386003)(58126008)(478600001)(316002)(16526019)(47776003)(6346003)(956004)(26005)(305945005)(6116002)(186003)(486006)(16586007)(3846002)(11346002)(66066001)(42882007)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:YdagLiFIDitgje4hNU7c9e4U1zmmY8pMME+gjuZ6m?=
 =?us-ascii?Q?liekqJVcCoDzRQTq0PccY6Oq9NWukAW2VpW8TtPG2SyPqsoIFMfp7ko62a6P?=
 =?us-ascii?Q?Wqgv7wijTcjfqzJXb3jQM8847f6fDvMdiAImbGbDK/CnjudbtVuwiCzmaAO4?=
 =?us-ascii?Q?FeR8PF7eUf5XT6twICG8UPkqkaWV8VDBUoO3PMUxHF0MX82xM2EUQOzATCOD?=
 =?us-ascii?Q?0lRjuhe0K4ALj6XYQ9ZuTpyKgoG67AefxaFMkfiefbJlrnbS3spyu5nKsigW?=
 =?us-ascii?Q?2G5lw2TkrFhiUEF5FZVKVrtLHjmpPmewEdmPVWv9YzbwbZcDbduH1hogOYyH?=
 =?us-ascii?Q?NWLU2p3E0arKK5M69pmT9xjly0OTbwE3k+cQTWx56BXRM5FrkyJRUXFsiXeB?=
 =?us-ascii?Q?C+qzEJ/+X3kr40hQSzSM1Vy/217PudBsNRoWmzpz1Zt86hdlpz/Udcx5E70W?=
 =?us-ascii?Q?eRL6SzFpSWUiEqEdt9IaZKxRjljqkyANvscMqsU+v+OsqTiHx+Meroar76nw?=
 =?us-ascii?Q?Dx254NIyTrsdp7g+kM/F1NjEOH1MLLJgzp/p70fcyT1VHbZEPQBcagjOLwXT?=
 =?us-ascii?Q?48L31sBwxfdbfCQk2dAAMXyG6l6FMPmgtBq7E2EgOEiE7hh8iUnd7qkmJGN5?=
 =?us-ascii?Q?sXBhMpJalwhrpDjnL5nNH5hLft5tKNoSA4GK1WHqxQld9AutGhUliasG84XU?=
 =?us-ascii?Q?qCmfUjMYMHpt3k9eMdCBVrd7NdoXtD4cW6RaytbKNIHyz9W5+6wZkfv3o0jJ?=
 =?us-ascii?Q?9Px++IRMlYfmujFhFTXzdl9sEZvEhWFaJcLtR/aS9u7WmLGu3nQDN7CUsnkF?=
 =?us-ascii?Q?qZeypj5cdW7dbqMVTE3cwMqF235u2ZJ0vZhW0+8Xzsx7kQTo5YdLxXAlsbsh?=
 =?us-ascii?Q?5eukSiHCYOudqzMpgzkNo6n4Xe0mV4hsSbgyJDAQitbLWF6sEkaotAWiEZ/o?=
 =?us-ascii?Q?7H/sL+AoLD++QedQjCXVwMzzXjuJftZ7/y3O94pU1jP/AQqkXLOfZMCR1PKM?=
 =?us-ascii?Q?TEXg+DjVElUdrIF9wHqIeW57mVJXO4JbbWXs8fV5YUx8LFI+qkWX1OeUVzHs?=
 =?us-ascii?Q?95FT2mPID/bpVfx+bD+FJJQ0nZrYZL/xiHaUSQY93WUcoLCazsgOYXT3W+RA?=
 =?us-ascii?Q?fesAEfzBKkg4GZLIwG1LIuUagKEWAlafy+QPsyBibYWfHcSrfBMDpdrGP90/?=
 =?us-ascii?Q?ypkKAJGl12ZbA5YyKhPL4rtjrIj6Uj629hkj9Gf5gZTC71v+xevofKKNKtQH?=
 =?us-ascii?Q?tauJoWcphItHhoLuSHQLlkOwVbMVvYwOzzJTTQ6nf35JRVjj4rA5Br6sYo+F?=
 =?us-ascii?Q?/TYLCQP/TFA11XP0TIl22jwZBG9T/ojDL6JhEJ912QDnL2gNRxmLufW/CWF/?=
 =?us-ascii?Q?HNRMQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: OpvyPh/eq4WhubgJ6R1kYkixG56JehutrxMRm5ws/qaPk7QJcJ94Ubi1fLhTrb3gsAbPLdNy7CgZLjba3podLfbfkafofJUIgaKxNII4ZBrIp6Yj1zQOW0McJVizaUBMYusGAgNJ2BuXpgyi76ljuMqAY6CsuDrUogzQZP21o/zjQY0dMFWEh+9fQbSf/Qbe1eeYsKu7NKJheyDQorFqtfPncr2cP32iTImOF04fiIO6jyoNB6BGNZjk4u24QuM90f1brMzfycRArhTWn4vqZtnJTBvX3ydoTPD92rfSCDjgMLJPPrIxOIxmH2VfirwILMFvxLh9OCIHRKLDHLspoZMOz3Cb0lm/uQrM87ha1Xw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:hLHw0NOWOb9fFXE6DapttcNxIH+9dhxk5bLj+QxUTTorXqmqYTe8fWPck+eto+IFX1rFIbrgLxqz2QHAJy5QXYH6pZ1G7K+E4wVei5z1T+YIO8KpyckyEYgp8ZRXUs8UTI9yKogpZfuUbn4azGlq35IFCfmKXONTPkF4RjXXUU+HVR+HTaCDk+f4W/BelHYIeUv4JTfMXG1VYOTRzSQYKcXWpSFX2EL2JqpKEqXWupM0PEPFGq708l0obPo00UrQ/9CgsoUvaekgEjF3Ajq8Biag22SSoeB08jwd2ifAfeRpX+GU1oGDTCxpZyHZqglGHHD1boMpRwVcsdzSyymXFQlZtXWSXGHbH+JL6Tpta5CrXfqB8274FsC22tuYfMQ74UIL95B/bumaiGqEN7IC/IaoA2EDQLZVfHp/Hh2EMhhhUYwN6t0lLStMVK5cqxXfq4266wTH9lOQaTMtptnwhg==;5:NjKSfCUq06IwK8C/y32WmG9iXIcadiYc68bgWRiok0xw2UHJZUwsVIt3BsHOl2/Ap5/ybieoKYLi5jHVsNhn5JlvoE8jh5XCUqIagqnk70qaoWSimaoRd7TQjRcN5xul/aOIz7gQH/QjHQdIn1OiRpOzFsAprHbuYAhBHcp1IT4=;7:13XdAmQNZC5Jdym2XEXfilQ9l5A4c1Ww+3F1ftOlwWTVQdRFr2sihZwMHhPxLDg8A/QtKD5IMFQwwxuHigSZv142qnptyDRrbuN3j65b/djgMQImhuDBBgThBQlsuD6YnVa1HJYV4TjbiWjm1igdunbgPcYlvjANhBS7YEAawUq/tIxVVIcXHOqwufug5XBQCblPG7dQeT26bIuhXyqJ8d8ATHn5WArJ66iMFwgPWGJ+ZwZyNXvZ/TMamq8nroxr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 17:00:36.4179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3e2e5c-c1ab-41e5-4bf4-08d607879d9e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Tue, Aug 21, 2018 at 11:49:48AM +0900, Masahiro Yamada wrote:
> The code diff looks good to me.
> 
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks :)

> > A straightforward approach to the per-arch header is to make use of
> > asm-generic to provide a default empty header & adjust architectures
> > which don't need anything specific to make use of that by adding the
> > header to generic-y. Unfortunately this doesn't work so well due to
> > commit a95b37e20db9 ("kbuild: get <linux/compiler_types.h> out of
> > <linux/kconfig.h>") which moved the inclusion of linux/compiler.h to
> > cflags using the -include compiler flag.
>
> I doubt this statement.
> 
> Commit a95b37e20db9 is not the cause of the problem.
> 
>%
> 
> The change happened in commit 28128c61e08e.

You're correct - I'll fix that up.

> One more thing, you are not touching any makefile in this version.
> 
> Maybe, you can prefix the subject with "compiler.h:" or something
> instead of "kbuild:".

Will do.

Thanks,
    Paul
