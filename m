Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CEFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E5A2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="IL+GIY5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E5A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeIEJKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 05:10:52 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:49532
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727155AbeIEJKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 05:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIMuAewmCwrI9CgVWtw0WfVfMmlVmnQxr75apJ7iRns=;
 b=IL+GIY5f1XEQ+cQSDgfbeb9Ah3ffDUWnQMSQMvbmJDPVp4JtcNxgWxrImgaAB5Fzs/mKv2htNhwm4UzwNmx/blpP809NrkFb5nqqquCf4ZXCFeRM2nsOa6CvR8UjIC/2tBVqvbwax//WiIOsZ1uenko9ZmBheAgUSCwQ08E8i8I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from localhost (213.57.183.250) by
 DB6PR0501MB2695.eurprd05.prod.outlook.com (2603:10a6:4:81::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Wed, 5 Sep 2018 04:42:26 +0000
Date:   Wed, 5 Sep 2018 07:42:21 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Regression from patch 'tty: hvc: hvc_poll() break hv read loop'
Message-ID: <20180905044221.GB2977@mtr-leonro.mtl.com>
References: <20180904174808.GS335@mellanox.com>
 <20180905071529.3b7a09c4@roar.ozlabs.ibm.com>
 <20180904211635.GD335@mellanox.com>
 <20180905135156.7ac7727b@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905135156.7ac7727b@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [213.57.183.250]
X-ClientProxiedBy: VI1P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::20) To DB6PR0501MB2695.eurprd05.prod.outlook.com
 (2603:10a6:4:81::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d065a89-f6b9-425c-ecc3-08d612e9fb26
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2695;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2695;3:68qzqaSOO410iAgRgyn6Y0fDGXEqbzhqL4HQxNp4auoR4YGSlz2ls6xRBhKCIM+jdF0cGzGYzvi/wxd+qTerhV8m0TOnjOH4/sC29bQvnISm5ss1MnhL8hbFfn+w3TjjsYMALiUPQlPewWX6uLPV1i9k3WR596OCiee+qhWeww4TA9oVTCBjEHePfpq+t+WxDxUJhkKi5hv+Uebp+WXjxojqgh6K4m+PfSepHkL0K3+NMep/74966srXpXmkRqR3;25:PuulgjCkUOFyvsgHHUuoYvgSwUTpoUaN1O+E5LHyhkO92cqPH7W8vdUeYrV2OjXgbUv5Bxw0PMbUdvDObHwfNwZceCFLhBZLf2PVaBOKGRAhjH/XlYAvUwJD8hMbVBQyCNDDwaJv0HOBv/ayvgeJJ/ito4Vx3fD4n64U0g90FKpiWL0tTduUeYweuzH6zwAWo1AuC/nHSIGbM3PzYo5eclo7+69esueNu03xqqc0o1V81KvvG2UMxrbER5SiNybj1jpqePt6vHGjY7GaP0YsbXbwnJTQ/EhiM3I+UHuCNzEhXN1NoUJZ4oJoVTFIKkiDH7dAFbO6HS62JDuC8m06Ug==;31:vkHoXakcTymd1eA0yF9WgcG5AsYEnRmQUIP2LrvJLojh9BQ5AViD/E/OZEhkyObNBwgqhCQY2HTLbLBgmJZMt9yYLwb/+emJdR/DkY/mnigdp+/gCgqocfpL6Gf+O9IrhVtjn6sISgxTOFLnRX5LMNtAL+eyKAl2Nb9lC9ER1DYAsAnBS4QlRlkrvITtPq42PBMj3n8ZgbOIit7Dc2kjO2cPLZpBcyoSMU7rESFS6j0=
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2695:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2695;20:oUZJmApn5QrZ/7Sk7zs0mTSkevmsVU0Ovep6olYvK+3TKaDWXOiBGtTt0MGVDqAg9lXVQ6HxO/3UPcax5oD+qHypOUf8RPSz3/0rmjrorFOdBFSGns9Mjc658hkhNd/nmcrDnJV6tba4Ki87qfvdqKCvGzSzzFq/Q6Gy/l4qZ2wm0AnQEK87UyBCk1EqgASlGMRQiPIegv6+gsRr1JbEO7Vp9RxUsVV3XtFdlBSdfE2Vde6fkiPefgQwedtunzS2s5WdILKNAnbOghw3AyfLvZgbTNjQ2Y9YVf2K4B3snRZJqSuSNo5A2aOTcYqCjqi0CtgZ8fwvU32RkqgKS017jY35/WSBE+TYysDKA9xNdyjKf75vpIeGaUdV/PzSCzvPpiizZrcEdixRVLEKsgSTVmmjKC1w3lyPAzZ3XSDelD7XhKIns7OhFb38B2bT3wuRj9ufCyoKyFXR5obdJccPPr1FP1daLgkwNzEz9lxq4CleR8bB9v/y5xGhD8LekLnK;4:hESjCJNi3cYyWaSrFfQENhnyfMRaKd6FndChtqlNI4JNmW+u0wWwrXjgAXJCBOClHvL3q+v4v0xemsf0VS5XDSXbw3Mcm+WSFocQC3C7bcfPHvr4G5ndRnxwtG2D/U7xRk1SmOcDsHO7o2m0ysZg3tgFsrIUECrqy0wzFSkumJ+koYbCHLI3uY+OhQYoJOVe0xK13caOnJ8aoa1wLKg/Agy87UyAgol+wZn+L1Ef3nbItS0FFMWNskIFLF5HRKCy8TMKIpx7WUFvPZEoB1oQxg==
X-Microsoft-Antispam-PRVS: <DB6PR0501MB26951B391D81DC78ED79AD6CB0020@DB6PR0501MB2695.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:DB6PR0501MB2695;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2695;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(446003)(386003)(11346002)(305945005)(476003)(6666003)(7736002)(4326008)(26005)(93886005)(956004)(16526019)(33656002)(186003)(478600001)(25786009)(1411001)(8936002)(39060400002)(86362001)(47776003)(97736004)(486006)(8676002)(81166006)(66066001)(6916009)(6246003)(23726003)(345774005)(3846002)(229853002)(68736007)(6116002)(2906002)(81156014)(76176011)(52116002)(50466002)(6496006)(16586007)(316002)(33896004)(54906003)(105586002)(76506005)(9686003)(58126008)(1076002)(106356001)(6486002)(53936002)(5660300001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2695;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0501MB2695;23:8IonUUCMlBxxKKrqjAhvuEGDF9jqZ8LORk5+4+O?=
 =?us-ascii?Q?1Z9zZnDDDJEXeI2Dc7sXB97oaW3sD2033rNkHCpvI5SFUlipA0GYVx+AZxyq?=
 =?us-ascii?Q?J+8o+cKwSnyP7Wi5RNWrzTwcWd7KSYOItyHAohhWpqH8STV999NCCIeGhkSp?=
 =?us-ascii?Q?gbVM2deyLbcBjH5YcHMgkvUYfAW6wsMEiPLX6P4dMl8EoC5NkktQOsO0nM3/?=
 =?us-ascii?Q?ET06FPPWqbPHmVIHajccux1lGSDE8FSW95nNyJuBIoMpJZ93QyIJrgKFpmjR?=
 =?us-ascii?Q?KZvsy8TX3ZcoJ0XP1q2/BQrsxQAW8yM0Ko04K+FFYjprMN9oYkWGtLXAft4a?=
 =?us-ascii?Q?CBCrCSWEztCZjg0oiK7sSHAMzrlo334OI+RUI4c9nbSKTwyi/TfOuRpmXkHh?=
 =?us-ascii?Q?4ihdcMKYrg7q7X7f8O6amnMhhbYE/kV67HQradxAIrPqkbM1/ymg1gEph2zR?=
 =?us-ascii?Q?LEdpwVz1Xrd8wcVpzGxWJRcjuHxIzQYC+vP5uvW28JCxjWPyWufJzCSniITg?=
 =?us-ascii?Q?VBUHWK2u9GRcihDDDwZBLPJI7ySgiNjL/iDkUKyQVKP+Vyqz3ZVPcDD8OLlV?=
 =?us-ascii?Q?edUXyudnU36TI/kanARHfSm2Ml+NAdLKgozoT8zXYc2Uccjsm/hpp5dm45Hl?=
 =?us-ascii?Q?Ld/Wdn9qwSQ9hX4VRdvp3eBeV3QGEqyv6avVPnIgIh+QAdvttvPF9F/fjhnF?=
 =?us-ascii?Q?j4qJqZLe7nPh8O8YUd7HSBJmJzb/twYef+4DBn/Dx8a5I4/7VQqZ+rt30P0f?=
 =?us-ascii?Q?3yxksQYCcg5BxpMrU/OG6HrM+PbSuQShyh+LRwiGp5dvkd1yZOrulvXo19mx?=
 =?us-ascii?Q?dM+GfUvh9aOA3t789HxQak9w7JTo7dSwHwDbx/MMOh2nqDgFYki6d4IMSeIl?=
 =?us-ascii?Q?L9WK6KCiLTT1Vq9/io1Vv4PsYO7qUNk0xUeTQeaeJ/dA9FgWot90tGD2MbnZ?=
 =?us-ascii?Q?RI67RPMG0hPi7DfuhJr2mRxLC2J/y8AUyQ69U3mD/KNvwafz4n86jQV2E0/o?=
 =?us-ascii?Q?CrE0IWkhz5qzssNEsHV/WodN/bexpu8crepMxTBC2OZ3iKLBdEynINDp9qGH?=
 =?us-ascii?Q?zsrvIboEnOZYAHfsV4gQO/RNpsGJup2+5//eiJOdvs9iUi3gFRHSs1sEbBtk?=
 =?us-ascii?Q?vVdlmlNqNJOTyJRjewwayiXfZzniAomncBh8ET4o16B4bc6+xAB48axk3uMi?=
 =?us-ascii?Q?SwKwLnxkOzHSAeZvedUCi7f9IzfXjHVXYCVYRKf1RM+dZC02TKmgCt7TgPrN?=
 =?us-ascii?Q?zT13HFXiTdu97DUJQkrF+9mIdjSGXreISt8fDneUgsjWsfIpgfF/BbpnTa/D?=
 =?us-ascii?Q?I37oUxFwIvMb+0MGJJppBpkGjt7M4ogVHgxjy6HgybgALKqJu+baSEKcplJG?=
 =?us-ascii?Q?W6oaKDPQq5CQbnk/PIRk7tXiPcHo=3D?=
X-Microsoft-Antispam-Message-Info: 4TWyJCXmUu6rgy1x3o4+UHcfEQXmfZkVOWUwvPaP9H5z8RHQbfm7TZEEIA1P0xQqukome9uJDwuksBFK9yiNBWyulU6R/bufbGPiOI+5Z8Fm736EFyRqNu6ae7GTS4wQQk9LtDHRGIJB5HDzl9ArTMw76/2T7zAEPFs953xL1wa39B2WV0EF2imTNtCrpAMA41IV8qldqhi3fdlITnWqbE07L4qmXPLJetMYKGxIig3aHeZmwPTxaYzrc/TiVNs1xHifm/4aZjH1Jq4O4zXS2Z3+vAdkXVHWiFrVnghR8Tj5XJS60oLKvccWGx6uxapyGZYNGWNErZYuxaiRMHPMcP5mRn6iqfOHxPC9gp9h4T4=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2695;6:kWcxBWKur6Dlx2hzWE9/YIjrZNwRaB/UefrERVBxLffi10PVIUTDlc8Ev4OsLyged5zPVXkTj6FsfPSpdM47T98fJ+IzeWb+5XoRDSRJfkJ82tB/jqo9eFI1tlWXqfvhcVCQNlu5qfOKdflUdTKfvp37u772/zrnB4a6Hoxpba57MdEa8RvxB51ekscopM36TYghprn4aKphZFDRtfCvvZfKdAm/wysLb6NC05FUMHCQsRW7lsmnuH+me09EHH4AWGouT2CERLqr75zJGg0NaGwkRS7Y2hcqYtv/miLzGDthCvyn3AMsgTqJzdIImYwOj4qDInPC3RM2rlKaTVx4rSi5j1sxo/jZjRszY/Ux8JJjz/EAV+DvO7n3QEuWxqHrSVMS0GDHoaWvuGR+d6IeO6weQMABZGBWStZtACDdOOdw6a7naum1j/cTdGdPw/L9l8tEb52JJ1g7RmjML2KGag==;5:1VAkhqA/j2ITK44Gf3fY7cS1omAkdt0PcHLwKHSJ7hz24hS5t+SyWEM3HpDskxkYvWOkfgndDG/deUEuvfbwG8zTZCQN5ITu+5L39Uc8ijgnLL6tHY/4/DYb4S+oz8nZYNIWRHUGeg3s+l5Fvu42YDxvJVu3vEMXQxvD/lAY6jA=;7:oAklH/c+FwnU7bP9DPc28HxizPnXYxXfMdHww5VQYeiM6xkfaeCijeHLN0S3oo3nKZYHg4gd5GCVru0MzKgSUXYlqyunQZOMTe+4yu7oRMqy/J/Uhf0bpKdcpNGN4CoX0pwzH1IcFhM03nxuJ7QJEjGSGscig2NMtPA/op/ZS7QEfja+57rdjjQjCV+vo94X09/IPQpO2X2RPHaNxo9J534/P/CVO3vlbFtyvYOj8h5AtWZTQREFhz7d/tvBv/CD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 04:42:26.6703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d065a89-f6b9-425c-ecc3-08d612e9fb26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 01:51:56PM +1000, Nicholas Piggin wrote:
> On Tue, 4 Sep 2018 15:16:35 -0600
> Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> > On Wed, Sep 05, 2018 at 07:15:29AM +1000, Nicholas Piggin wrote:
> > > On Tue, 4 Sep 2018 11:48:08 -0600
> > > Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > > Hi Nicholas,
> > > >
> > > > I am testing 4.19-rc2 and I see bad behavior with my qemu hvc0
> > > > console..
> > > >
> > > > Running interactive with qemu (qemu-2.11.2-1.fc28) on the console
> > > > providing hvc0, using options like:
> > > >
> > > >         -nographic
> > > >         -chardev stdio,id=stdio,mux=on,signal=off
> > > >         -mon chardev=stdio
> > > > 	-device isa-serial,chardev=stdio
> > > >         -device virtio-serial-pci
> > > > 	-device virtconsole,chardev=stdio
> > > >
> > > > I see the hvc0 console hang regularly, ie doing something like 'up
> > > > arrow' in bash causes the hvc0 console to hang. Prior kernels worked
> > > > OK.
> > > >
> > > > Any ideas? I'm not familiar with this code.. Thanks!
> > >
> > > Yes I have had another report, I'm working on a fix. Sorry it has taken
> > > a while and thank you for the report.
> >
> > Okay, let me know when you have a fix and I will be able to test it
> > for you!
>
> Can you try this?

It worked for me, so it will work for Jason too (we have same setup).

Tested-by: Leon Romanovsky <leonro@mellanox.com>

Thanks
