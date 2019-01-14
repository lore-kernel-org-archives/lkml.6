Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1029CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA4A206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="Mmg6lUp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfANQyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:54:06 -0500
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:30944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbfANQyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWOChyH8YHHJzrvd8V7h3olnTbRC1wwslkxp6C7M2is=;
 b=Mmg6lUp1oTF3qq/EJkJ3xT7Wy7jVs9RqCq/WrAorOF/WMXxgVf5myrElQD0XCqjgUG3b/W1YGKiCIbg/BVHHdlWD7jxxPEzScWeaxzkVxUqlSkwlIDrjyAdwH+O+asimSmAhklY/py6A3gHaiAI7PM5oue8jObukq16lGZr01/4=
Received: from MWHPR06MB2896.namprd06.prod.outlook.com (10.175.138.137) by
 MWHPR06MB3293.namprd06.prod.outlook.com (10.174.250.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 16:54:03 +0000
Received: from MWHPR06MB2896.namprd06.prod.outlook.com
 ([fe80::d992:bb7d:56ec:8946]) by MWHPR06MB2896.namprd06.prod.outlook.com
 ([fe80::d992:bb7d:56ec:8946%8]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 16:54:02 +0000
From:   "Harrosh, Boaz" <Boaz.Harrosh@netapp.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
Thread-Topic: [RFC PATCH] mm: align anon mmap for THP
Thread-Index: AQHUqeoAUFTCAIIvn0CcxSCAmIzKA6WqnMwAgAAaIICABBVXAIAADyeigAAgWwCAAACfyQ==
Date:   Mon, 14 Jan 2019 16:54:02 +0000
Message-ID: <MWHPR06MB289605B9E1B4234674CB87E2EE800@MWHPR06MB2896.namprd06.prod.outlook.com>
References: <20190111201003.19755-1-mike.kravetz@oracle.com>
 <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
 <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>
 <20190114135001.w2wpql53zitellus@kshutemo-mobl1>
 <MWHPR06MB2896ACD09C21B2939959C8A8EE800@MWHPR06MB2896.namprd06.prod.outlook.com>,<20190114164004.GL21345@dhcp22.suse.cz>
In-Reply-To: <20190114164004.GL21345@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com; 
x-originating-ip: [207.232.55.62]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR06MB3293;6:khlcOdszMMVFaK93TvVwWN4XIxBgkL29DD3FbBawBciL+1Mxi9FG5otyfSdQxceHB/E0MINzOVhDLcLGm/dC2wHeXqVI+MeCCx7fKP0yGpCRqMWzHTYOclE0Pw9x5/2fBZRdcw4XwQIU7NZnY7muKAdXfwhD/J/QddcNsQmmR3CwBEXNjDI6Xngt7NSxBUKgdNx2fDgUR+4BWszeHc5o3C8hIZSwNgJ5c0aRoLj9B2N01TDx1njvDsCxdaqtTtZAsq6zFLAWyxc8riTzl+oKzI1VujM5XsR8hrFLtRvfCUsMlzHjooGUpHkjaEhwSOUsWdMWkG0h0WQ/DBq9GOwDhYslFjeHAhAgfT8mYsqwxMHpmnfWnJpM/YpyEVe+HnZutgT/u6w69U0i1Cpd3vAVcz6pPaD8CoSIq/tBB5Z81BzHkLaAG7PTclmqRmGBuLjNCToRc0zePPs4SeX84rffLQ==;5:4Zg37NUe20WM5IYSiU0ho0OL7IPTbDUv4LT7OYjtddKwEo7Rnfcq0WE82jtie2oX9xBUY3OND/Nn/NZTsxJ0mxCGlirDnlPXi/q52snYrPO1xZm34LaRIQJq51j+V6trrpHsXnT10cnAeJOjgD2zUPj4Ib4APCaO9t6QVTkM2wXcIJG8+S3O+6bRuYq0W1sEBGGo8k3xjAwswLNvIh+5cA==;7:pJGoLjgYVLOfzg0ZreZBXtgyIvV2ZpHIHZRmxkvlatwqaWbbTGw1wOC/nFq5qk8WkREunJ0ARlH5+xgTchJacJgjqDqn0fhGMTXswwFWa1+dejOM8PEaieQeWMG6KV8KA3Y3qku/sVQArAUnmBZfnA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 492ddb7f-6899-40da-b593-08d67a40e34d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7193020);SRVR:MWHPR06MB3293;
x-ms-traffictypediagnostic: MWHPR06MB3293:
x-microsoft-antispam-prvs: <MWHPR06MB3293A94A18D25FB9A1B7F677EE800@MWHPR06MB3293.namprd06.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39860400002)(189003)(199004)(305945005)(26005)(7736002)(105586002)(66066001)(186003)(106356001)(102836004)(5660300001)(11346002)(6506007)(446003)(74316002)(256004)(25786009)(6436002)(229853002)(97736004)(4326008)(86362001)(53936002)(486006)(8676002)(2906002)(14454004)(9686003)(99286004)(476003)(316002)(8936002)(71190400001)(6916009)(71200400001)(6116002)(76176011)(54906003)(6246003)(81166006)(7696005)(55016002)(33656002)(478600001)(81156014)(72206003)(68736007)(3846002)(7416002)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR06MB3293;H:MWHPR06MB2896.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /qVjTawItMjff4TgXOa3c/yUvErdGlg9ieKFeQs0fbPrBvQo4KzjuPFOKOg8xWUHvQeww5bn4ZriiW35GdbHoVXuo98LDBeY+k8L77XD3bxhe4iHV8OTWo0dT4hYetvqUwUGe1V5NtiNly16KJIkJdqfqXRywf+do9lUF48DJD7ZJJ7tLeCqCozuY26n5CTAGARjiW9aisR1x83rryVmUThNg+xetWjDE8LaW2Y1stoid1VTtn1DNDAEt3BOgTJkZl+J/Q/0LW1FR9T6lkWUUIYQHkRLyNgT4V2Wid0TcIYInAFiFk7RlT+kNVAGYrHCkdcphps+rqgk8PNO8CXWImuIzeQVDIjdZ0pg+Rwt1Vywm+/bOtCfAq1RdikzuiIklXzmzVxVB3N4Q2/4210uy7DCNWJ60eWz4OJ7HCFY9XA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492ddb7f-6899-40da-b593-08d67a40e34d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 16:54:02.7657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB3293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> wrote:

<>
> What does prevent you from mapping a larger area and MAP_FIXED,
> PROT_NONE over it to get the protection?

Yes Thanks I will try. That's good.

>> > For THP, I believe, kernel already does The Right Thing=99 for most us=
ers.
>> > User still may want to get speific range as THP (to avoid false sharin=
g or
>> > something).
>>
>> I'm an OK Kernel programmer.  But I was not able to create a HugePage ma=
pping
>> against /dev/shm/ in a reliable way. I think it only worked on Fedora 28=
/29
>> but not on any other distro/version. (MMAP_HUGE)
>
> Are you mixing hugetlb rather than THP?

Probably. I was looking for the easiest way to get my mmap based memory all=
ocations
to be 2M based instead of 4k. to get better IO characteristics across the K=
ernel.
But I kept getting the 4k pointers. (Can't really remember all the things I=
 tried.)

>> We run with our own compiled Kernel on various distros, THP is configure=
d
>> in but mmap against /dev/shm/ never gives me Huge pages. Does it only
>> work with unanimous mmap ? (I think it is mount dependent which is not
>> in the application control)
>
> If you are talking about THP then you have to enable huge pages for the
> mapping AFAIR.

This is exactly what I was looking to achieve but was not able to do. Most =
probably
a stupid omission on my part, but just to show that it is not that trivial =
and strait
out-of-the-man-page way to do it.  (Would love a code snippet if you ever w=
rote one?)

> --
> Michal Hocko
> SUSE Labs

Thanks man
Boaz
