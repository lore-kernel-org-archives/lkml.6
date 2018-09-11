Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8639AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267092086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="RUYUIjtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267092086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeIKWZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:25:45 -0400
Received: from mail-bn3nam01on0137.outbound.protection.outlook.com ([104.47.33.137]:48928
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726943AbeIKWZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnZDfr5csmZ8Qs+HOUfb9PLl5Tfza2qrsw7k99YYvCk=;
 b=RUYUIjtguEI+UZlcDiRi7kPzkq0Wj+3aXxigWTUpSEkumQ2Ej/2D7Bgi/X8YE3qwr1x3TesBQy/OH+6tkIH3913ipxeRi4lJdeAgH56AcrKxvRCvnVQ2JrrnNDVGEq9EmJdXMUT+PPLp3uRF7rJ0fm1XyNRbgs24h9qxObTVack=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (2601:647:4100:4687:76db:7cfe:65a3:6aea) by
 BN7PR08MB4931.namprd08.prod.outlook.com (2603:10b6:408:28::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Tue, 11 Sep 2018 17:23:42 +0000
Date:   Tue, 11 Sep 2018 10:23:38 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] MIPS: Fix CONFIG_CMDLINE handling
Message-ID: <20180911172338.xdqmkmp3brut4ish@pburton-laptop>
References: <20180907185414.2630-1-paul.burton@mips.com>
 <20180907185414.2630-2-paul.burton@mips.com>
 <CA+7wUsx8gmDNh_kYAxx=PUR2gNJFRCLNYq=hZE79jT=yjNrj+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUsx8gmDNh_kYAxx=PUR2gNJFRCLNYq=hZE79jT=yjNrj+w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
X-ClientProxiedBy: BL0PR02CA0088.namprd02.prod.outlook.com
 (2603:10b6:208:51::29) To BN7PR08MB4931.namprd08.prod.outlook.com
 (2603:10b6:408:28::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf362691-d919-4d5f-3e76-08d6180b52b8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4931;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;3:nIMj8UGFLX3FbXHYzOMqmx6Kf+l3zHDkdMZTXKBb4vVILoymDErn5hYpSASd5Jntcaw1Pu6qePs6ICICgLHfpc/uyPTZY2K9cXB4/L+MkKIp4A1cUmCsHQkP8U4uE3T06w6NPRdHZwPwFxcsMXrKEwy85fk+/3eifP+WjlTfnGTCoZt8EFqy8ii5o36oX2ruM0nxwD/wCOzTKs7QbHhTZwE/oEGb//Kg9GSWnk02zcl5ve9/7zIlTRjFWvfZg/jB;25:+7h2fzupb2PUyRXD9uIPgsgc0CUG8Pbr4UufHR+NGoq/DVjA2UrZBU0B485CYvZBLF+mDvo4U3dboe+fmyoBaYOaU+ZFPSu9Fem09qZtMJdsA+sKMp6CmmjLAmalHdgtskGJFjIZv8t10QLd9c1NTH4XpURH0EwD/tlKilwrO8fbptoVL4A18sHHyN4QmwemaUmp/kE6No+u183aSL/2utRxnFW2fkPFvvYgWiHoViCmI4dv1KBE1DfdJxgOB4qPslJdwqARmsiZNydDLX0bZGs43LuzGS6fjc7S9D9zZ7Xmb0jaihXXpXia4jMsNDc/gjYFIEG1/C/n9Vs7eowa3w==;31:8U3fTYS4SZFvP6G3E3Kc9YBvrIRxq2SDBN+GlXiX6wHoRm5bwJX0Y8v6hgu7DThumdtHmLWb13VZuS0VWW5CEktNZslw7E2Ib3pOuShhd4XuvMtBPu7zjgFw9oK4T5o5HwLvXkBTA0ITT4x2FalN8fIHnDBTIzKduupWV+PHZY2zQF6dFDu/Qlnx7YHNdaeT+0kk/5/qHX5/hK/jq9VlzLvPOoVNWSEerU3n0u1HzEI=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4931:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;20:0koyYKv23fhdFcWjtPh2n0hatbgrbtifnCnvshvsQeSNSQBCX3hGZ8KDpaeEDBLwv7GTexypP4AL1+hXAa0VKjypVZld9YjszyEu2mHYbq2/B8RNL9wS5SnY4ynTh7OCxYtzGCyYz8ql1x7CiRt+MTCqgmdk+b8C6eCKf1eWnNnUMqjSBxDfyP2NdVvohLmVIl3gZrU+kwqqM57fnsJS7Nwg9b+Fac053Bv+46oaNsOd7U9wBblIOhk7RULRnA3x;4:fwsM4kctnEyfrTDqzKFNDGZrY30NyfR8FhBA48kQbhjC1SKo+4uMzFLcPqlpmpiQJHWfHdTu6ynyLC1N7jihsBs77jvXFcZSlBhF828khf5yJda/kgj2hiSZH15wZqnz/VD6TTe+AtgO/wX9/lbuXDpax4GtbGK6pKOwg8h5hGS3e5J5d38N7v9kmx7MtT4U2k97dajk2Hqq4MJyg2X4L7R2ryaynyeb1PyfvBrRPV+eAZ1uVF0KZ6Pn/YLVCrpLc//HK567FsA5mVxY+RcKhw==
X-Microsoft-Antispam-PRVS: <BN7PR08MB49313F5D3A5C79E012B74E78C1040@BN7PR08MB4931.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BN7PR08MB4931;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4931;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(346002)(376002)(396003)(366004)(39840400004)(199004)(189003)(81166006)(81156014)(46003)(53546011)(50466002)(386003)(7736002)(106356001)(105586002)(42882007)(6666003)(16526019)(6246003)(68736007)(6916009)(8936002)(186003)(486006)(316002)(23726003)(16586007)(11346002)(446003)(1076002)(58126008)(6116002)(476003)(54906003)(47776003)(2906002)(478600001)(76176011)(4326008)(6496006)(305945005)(52116002)(52396003)(39060400002)(44832011)(33896004)(5660300001)(33716001)(25786009)(6486002)(76506005)(8676002)(97736004)(14444005)(9686003)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4931;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4931;23:O/DxZvgMKENmhco1lQEOG8JGdfa1SBT6FFVdoDYq1?=
 =?us-ascii?Q?6Y9pah1z+Bo6xxz/jZNjOGN6XTN9kUy1v8fIb0uQxnhhlGdfQzT9EtqD2QJg?=
 =?us-ascii?Q?rMkictG9rgDy0ZAr4GmQYxgLCb3szX2b/i3DqBW4CNRdTmnJAphMd0cNnczX?=
 =?us-ascii?Q?6AiKPdwAEkTXTCGDfez8ABicrCNKG534FX4oohludw/DmsxHcnqLC+6N0FpG?=
 =?us-ascii?Q?LkhIS6Bv4sY95UjBUc8/FjjGktW4ndNYvcyRfC9QK4BGsmYJTPX3e0+JeVJZ?=
 =?us-ascii?Q?iOkJ2MZRfYy7hovjg0otflVOS0sMh9esmVp85NlEeR6XDYsygJ1Uv53L20nY?=
 =?us-ascii?Q?5Q1GTsBuJi4SmsckENYMe1l4oNAbDBTnhvopSnxmiuSCNMYZPNNv1tA74J7e?=
 =?us-ascii?Q?1FeNGwkdszmmFlVMAb2yVt4jSqtJ7EsTnyN4Vwkjmx5+t4WJnyhWlL8up8p/?=
 =?us-ascii?Q?ImLISgylIW6JzEPYzuYH7E6HnMa01iGa5oeOxNUBSY4In1MEu0GRpSoX0JbJ?=
 =?us-ascii?Q?v++sDmGXyLogTh+L2PlwD8QN1N4dFFHRjmKoxOnadlwsdXXLD7o88Yw6CMN/?=
 =?us-ascii?Q?mMIdusOtQf+i9icWvYcHXKLQ8p+/4cdBTJ+CGjXT+9nb9dHG+/rtAD4Mglfm?=
 =?us-ascii?Q?mXuzy2/rVcuemcDXb59MLqdodgVKjXjZ1J1uIIkwejuOeISCabpzLff4YEvG?=
 =?us-ascii?Q?12geyEypX3VmKcCvpW0PvZRfMLLkAydx7Q5a81OWrB0IbnE+5BR6P3q+Bd7B?=
 =?us-ascii?Q?Dmgi8WUbEsfpoGViRyNhKEGizdKAz+HpoW9Y6NowOjqLwl6VAF6oTr354Hyq?=
 =?us-ascii?Q?NoZfmSHnTdUCjdBuSU/lStSfGrsyMP30ck9mqfbS9zkT1LRchWipn/oDc39M?=
 =?us-ascii?Q?Aj5QScXaH4SKMK6JmMbxZujL42k2RpevWLzROgohmgEydMwljHGtvYly8Dmk?=
 =?us-ascii?Q?qR6nnwKddN1n2qOfOEl8PLrcwFtjZZqqSqHKJ/uitrE8Qln4R9Xk0uZvr/Ci?=
 =?us-ascii?Q?ROxwY39p2de+y7yK7op6VAg/HNb+jYiRjiyT5Lenhlmk8DPFbTCg4xm6OJN3?=
 =?us-ascii?Q?QBRWwceR9OvVIez20PKSoiAgLOFkLHnlB8xxRuqqjOhZMsDLgakurMhwhGJ1?=
 =?us-ascii?Q?OjulJeIVuapS1FOkw53ufB6R/ozscN3I9vCifSkA2Xq472lQVHrxAZsnqUrs?=
 =?us-ascii?Q?8PHDPkZWb20/26f03kBoIg6hRRr/LGUifMVPplTp/PYEDIBH75EkUvtMw9Ns?=
 =?us-ascii?Q?XJXG7+etbnur4GVuxzAKDNM0kkw7TrG5JUwLtd0fp7JG56qZ6zO1NMGF7RbX?=
 =?us-ascii?Q?V79jeXhmdLytdIEhuRu+ReH8HD0wxW1UpLUmSSc0T44?=
X-Microsoft-Antispam-Message-Info: CD90r6igtleh2Jg+AhLcws5Dj1gEyWhhZwB48ab5rbMW7xWXJBGETHUWF3iV6O6co/it9Z4lGzEmo3uFAXAfv8I4auXta7jE4Zkng9Z89gDgV9nJI6ia1iKLWxnDJYKkUY86YYtccdTJLcUANNgN/0b3fBHH8DTa7YSecQQFI/YH/N3/wq9x9kVYzRvfnfV0+bw2ryBHzircgNk2SfgmS9WmImmP6h3hVvL6B2KrkyudsYMDj0qEaFPA4GRNxm4ckjxOGzQmkRTakPCHLbJudlVw/LFspj8iyaysrdp7q+NukAMgYHkScr2/8gsqJeaGhLrc4VgP50BLunLYJLZ3mL1cjOcHwllqfoZQA6QyTGk=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;6:0RjYQSFdnRvQ/RFR9roTyNTif6Z+tffHjFWlHQCmN7tqzeUYOL1pw1a3IR/b85GMcTKYRzneguVZZYfndCAtgRuTOmFwXwyBOit0vtRidE8cMPn9Iygx8kDdTCnChPq0wyMlFVZRKRfFarn5nqUBHDnZxZr12EJZE40rBBEb5OKAVYIiPwMpiBaneDTChMjvXaKRFXJAodWA3T/dMI/qBt/7/EKLXqNN/gZ5UIwDujSqIfu7iNTuu7J2+uWIkQuYBDi32wPGA5UtLwAnIe8S6WY8t7kTHF395NZ8/5DCbds5jJ4LooGsDXv77Gy+5bB/y8CJYlZzytCoJU/+cA7UHgCWdqMcEDlwnTqHqjZHEkqcJoNdpRUzJ8qu67dDXGNRInhvKiMqszEDWuqCBfSVA+anNC6LmNBBpRY+XHGRgEilBKWo0iAb3oBg8++usYJ/te3OYiUd1jwdRRTgMWiXIg==;5:LGt2goXkz24GAYPD+Z1YvOYAO6+Gk0YtAbg5TmlxGxNY1xK3X24v/mBkO0SjWZhxiQjUsYwCzif8RtnQFdKIAIQkR2CT77YJ94+gGA41mLK5LCgZ+ZRIYPTHmOIEkaEiBF8zYK3YYzGtb2dfNXHfCS2nWMjqGGtlbV9tPmakhMo=;7:Yow/NMODJ6fs6Fdp7k5U97ZtSIb2Zk3BQ8SgO5uYxmu+8rEo8O5Ljz71b4IUn1LIvQWVfb+sARVhlpGSusVXYVAJvlDKPsEUYbSf8Gf1JD5A1rE2948QeeMOwwwLz7+Bf0kDmS6ve0WNkymhDRt3wtjNa1eht1i2MZp0meMcMzf6ZEjPWXLC5EjHC/6lSIMMGqTmq5BN8aiIe2EA53zumk+MDKdssjHazNwZEmuHVuEMrYL7c5XYtZSFZyzEkd58
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 17:23:42.8755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf362691-d919-4d5f-3e76-08d6180b52b8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthieu,

On Mon, Sep 10, 2018 at 02:09:21PM +0200, Mathieu Malaterre wrote:
> On Fri, Sep 7, 2018 at 8:55 PM Paul Burton <paul.burton@mips.com> wrote:
> > Commit 8ce355cf2e38 ("MIPS: Setup boot_command_line before
> > plat_mem_setup") fixed a problem for systems which have
> > CONFIG_CMDLINE_BOOL=y & use a DT with a chosen node that has either no
> > bootargs property or an empty one. In this configuration
> > early_init_dt_scan_chosen() copies CONFIG_CMDLINE into
> > boot_command_line, but the MIPS code doesn't know this so it appends
> > CONFIG_CMDLINE (via builtin_cmdline) to boot_command_line again. The
> > result is that boot_command_line contains the arguments from
> > CONFIG_CMDLINE twice.
> >
> > That commit took the approach of simply setting up boot_command_line
> > from the MIPS code before early_init_dt_scan_chosen() runs, causing it
> > not to copy CONFIG_CMDLINE to boot_command_line if a chosen node with no
> > bootargs property is found.
> >
> > Unfortunately this is problematic for systems which do have a non-empty
> > bootargs property & CONFIG_CMDLINE_BOOL=y. There
> > early_init_dt_scan_chosen() will overwrite boot_command_line with the
> > arguments from DT, which means we lose those from CONFIG_CMDLINE
> > entirely. This breaks CONFIG_MIPS_CMDLINE_DTB_EXTEND. If we have
> > CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER or
> > CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND selected and the DT has a bootargs
> > property which we should ignore, it will instead be honoured breaking
> > those configurations too.
> >
> > Fix this by reverting commit 8ce355cf2e38 ("MIPS: Setup
> > boot_command_line before plat_mem_setup") to restore the former
> > behaviour, and fixing the CONFIG_CMDLINE duplication issue by instead
> > providing a no-op implementation of early_init_dt_fixup_cmdline_arch()
> > to prevent early_init_dt_scan_chosen() from using CONFIG_CMDLINE.
> 
> Sorry I cannot test this patch ATM. I've simply CCed Paul C. just in case.

Thanks - for the record I did test on a Ci20, though I was booting using
my ci20-usb-boot tool which doesn't currently provide a command line to
the kernel. CONFIG_CMDLINE didn't get duplicated though.

I'll get back to a v2 for this & hopefully get it fixed up for 4.19, but
it might take a little while because my son was just born on Saturday :)

Thanks,
    Paul
