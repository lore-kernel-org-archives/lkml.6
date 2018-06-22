Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B7DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2768224471
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HkG8oZCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2768224471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933580AbeFVPNZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:13:25 -0400
Received: from mail-eopbgr720089.outbound.protection.outlook.com ([40.107.72.89]:40728
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751233AbeFVPNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWMjTfWCkGLrLGYcc61uz3uGFVgg3zZNpQaM1a7ifFE=;
 b=HkG8oZCNWUpnKOhzIjcwl5ZktXw8lD3+Zx0hYu0ceQCCKb6azWC7ejbsn8DK6NikNryfW2v6vKM6UZ7EIBjnzcGJja9BWl+Aq09jMzgH6Y/fgPU7ReJ6/qyPk2oQly2VCfTcuIkeZQwVGa7lBTBG6b/4gc4n7FEEny3f4gSXinE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 BN6PR12MB1714.namprd12.prod.outlook.com (2603:10b6:404:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Fri, 22 Jun
 2018 15:13:13 +0000
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Felix Kuehling <felix.kuehling@amd.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0aa9f695-5702-6704-9462-7779cbfdb3fd@amd.com>
Date:   Fri, 22 Jun 2018 17:13:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622150242.16558-1-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5P194CA0005.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::15) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f25f5291-9497-4351-ea62-08d5d852aef1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:wmCUPy1h/QaF540gpjcHA19aJHvNtIyvE2RONKUk/3idCSUbmnjyUQwhONWNFCi/oC7/ZmAaNAf027zTXPEWtzeNFMv/8jBYZ7L5tQAXDEDxLcYghwtun9zIiaWPdvdF9TYuw37OLQPnB5KdhvXN7gV7VKjlUfbuLY+xNMGqalUTeNjjOUO9iP4Pqehzb/PvAi16ocU31GnCsCwWz6yEBKU6qDMS8urUOiChzcCOD0JbLDkFJUqWZ8dphk8cuavi;25:OWw7DUDykENsaYdrDtAM3S76knxl5tJN1kDK81bEQ/2jx4AV7oUhIEou+MivvaX5jdnItY2YNPzO7vNt5PCOWkYpdWu2j4g5EhKeOIHxz3UfKnip/qtgbaHc/SXyelKMXSf74NVoVSHgSu+GamaRP7fHHfNVi2vr/+F3UY05G4trw15p9JvGnJLWQ7yZehVITkF/bFG/jsCKXuAuZ8DELePjtfRyKWGSEQhkLVGQncoeL24blcTegHujAqGCWZ/xdv6BdeQl66jyhYIZ7ts06js0Y5SMT1tsSqk7H3p697Ehvheu6C+Oivqv7gwoBLOTCdlP5JhxJt8I09rSEMOdFw==;31:xoZ9f664HrnCbkSFcMBAt3hz4N/RHehMKyA99EHpMC1tpzISjSnD2hU49aZMRCF6kvydzh+avX2s6cNFEE0//oiBSpZ/D2EiImKMWQ/aGmXORvIjoKSGJRfrKvUQ/5v5LjlUYHuwMmt1byoZ2CZjBYXhyD4PbgPwcXJNdCr6mEp6QvmotVF4TRyIsZnFkF+gHTNNRcmkejp8OkKgd26btNNnI90ahGrJJjREmBwR3/U=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:bAa5KuMtQwg1Q8FAFdXaCkMQZbFrogHS7clx+gQ7ij7qtjycOTSQhJoQ0hV9mDtrwWEQJyBpcbtz3a1TkYvxPHR7LgFpigYvG8e3nTw15dvgKXvvaffHoSkGIKYdhBaebTK11tuLVaVNMy4pHtkw45Ve3HRhVg1rthCLFyKtZMKKhjrZqY3RQFeIEg1yCesWkbLJZXM0LUEVwL4QkrGV70fLQgBTjBm07sPhH+x+Q+FfXHFFHmb1jjMkwLQCI8gLDcjSC0idBqfdHB9MC+OAgwxFI22NggL4l/hIN4+cfDt39sZ7wJdBeIV1W3uT+ROEfVNKhgw8sJsxgAhp5EeTRUY8zZhHgk/lACqPGRr6JXAY0cG6r3HNvIBp10TvYw8qVNysyLSUN9qZS6R9VLc6hrsZBLjmkfZLajgFfOLI+jnFG7GHspBz2TLp8jt9n/bQ2B+b0vx5X11rhiagAAieMRsr/3mcRTy9LaoiXT7MOKTE28jR3OMq4w1RC2Qhormx
X-Microsoft-Antispam-PRVS: <BN6PR12MB171446A2726BA5551421096383750@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(58134797142442)(211936372134217)(217544274631240)(153496737603132)(146099531331640)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;4:XKaFozp9vCYSA79H7mBnKi9pavTy6ztjKIHKVXoII6t/nzzy8ts7UQN01cLQLjF9Ng2oOo0jbHnKVxegTS0RhYg9t4SrdkNnAnNCcj5qvO16aUyY2OaXf7FdRcsI9nIfb9sbF91Fa4qmcclFurVt2j8MxJJ6ntskcaXKMuByVdSv1rkjQwPo/8K5IEZ48KWtQDm4EpuvS42AaLTnlKGv0cTYdwEH5/B66kNQdDc4sz+CEGuVwvLoEzv4SP1dAM3qhg4JVoOpM9w+fCNbkohX7v8KyXxxfJYC0lqhNtIasdrOiBs78w6rEZNqLB7qz51W+PYm9I9/M7Us5Oi3LD2cSqNFSPtdZAOTIUklWympcSAYlCDNeAwEIuiIJYpBAy7rMvoUVW80wP13Hpm7J3of05x+Tbl36jKreROdCF8SOWKqss7EQwTHqHrff7h6142BDnFkJ5wH2OdgZzzzUrcXls2/V/uca9Mwy2ZxMFm4baWNnJEqUAvzDvJMJE26urqVljvu6KB/GcSji5oJXPJdBX0Jt+U6sHlgkRdDwdCVQAA=
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39860400002)(39380400002)(199004)(189003)(52314003)(6666003)(5660300001)(6116002)(2870700001)(105586002)(7416002)(1706002)(72206003)(2906002)(476003)(36756003)(486006)(97736004)(478600001)(46003)(5890100001)(31686004)(65826007)(68736007)(64126003)(76176011)(31696002)(81156014)(8936002)(65956001)(4326008)(11346002)(229853002)(81166006)(8676002)(59450400001)(575784001)(6486002)(316002)(446003)(86362001)(65806001)(7736002)(52396003)(106356001)(52116002)(386003)(23676004)(2486003)(52146003)(305945005)(58126008)(54906003)(110136005)(53936002)(47776003)(6246003)(67846002)(16526019)(25786009)(2616005)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOjZFYTVDSFR4NUw1elNWdWVmTmxleDlZL3VT?=
 =?utf-8?B?bHdkbjVRT0NIN0UycWV4QWFScnNZUEZyWXRuY0ZrV0RhTkN2RWg4bVpQaGNr?=
 =?utf-8?B?MlkrL3N5K0NxVFp0VElPVmpFVURibzYzUXVRbVBabUxRYUR3Z0xoQWtvMzNu?=
 =?utf-8?B?ZXY4djdFUU4zaWdJZXBFamlTTmZaOGpOTi9vY2JlMEdkTFFoQThyMXgvbEN3?=
 =?utf-8?B?RXczbkswYmdjTGhjQTExT0RFd1BzaFg5TTl4cFErK3U4bERhQUhBcmd2WDJN?=
 =?utf-8?B?cGd3emo5ZFlLRVdDajhVbGVvZDRPZGVWczM0ZTRNSm1oQkFZczBPWEI5aHJp?=
 =?utf-8?B?SFpPanloYkF5c21PYXNBalE3T1N0R1BpWlcxS014OTRxc2lGSzErWTQxSmVu?=
 =?utf-8?B?cXh3TFB6Q0ZudTgxelA0TjN1NlR3TDZDN0wzcStsY0lzaUZ6T0E5QUhrYXQr?=
 =?utf-8?B?cnYxOVNld2ZBb0NVc0hpZktLdjJVcnVXMlliYjE2R1huUEsxbldJOGlSV20r?=
 =?utf-8?B?ajBkQTJrTlJDNVgybFFDb25FQUdXZ3ZpTW5CZWhuUkZtbGRIbGgydlRnWHJX?=
 =?utf-8?B?ZG1IVE5idHR3N3drZWMwOTUwWDFDT296YUQraXY3N0RDQ2lKcWxzNUliNDBX?=
 =?utf-8?B?eWJxcHJJK29JRUdUdnhlVnR0U1FTenhyYmFtWHhkRk4xK1NQMjR6eDEvV2wv?=
 =?utf-8?B?Qzc2NDBzWlZaK2xnajBKY2M2N0FLbW5XamhrSDRsTnRuSWlGMi9GWFdERjFh?=
 =?utf-8?B?MkY2WlB1VUdsMEFhdGY5YTgxQUo1V1h3UnlMN2tQb1BjVEoyVnVOaHJWVCtY?=
 =?utf-8?B?VXdQUU0wK2VPSk10aWRoSkgwZldITGtIVW1QalU2RDN4elN5dXZYZHhaQ2pH?=
 =?utf-8?B?ZUFNVDNUZkMyQUVLalk2UG52akdKNEY2VWFxQjZBNFZuYU1BeGlRWTF5engx?=
 =?utf-8?B?U2NQeFcrRSsvMmpqNUp2OEsxU25lMzVOYzk3b045NTNSWmF3dmJtNzZKVndo?=
 =?utf-8?B?dHR2bU1sNWd0bGZIY2pRZDZsUENndGdsaXNJa29reUh2TlJpZG12cnU2MjNy?=
 =?utf-8?B?bTlUTUxGb1JEa3d1WXB5eWVuOXNxNGVZVU0weENOQUFRR1RldEhYR2grTVpZ?=
 =?utf-8?B?cmJ5QzJyWHlYYjgzc3ZyQkxXTEpZVjZIVnd1YmtXemdRN2V1ZmFIaktKZjdn?=
 =?utf-8?B?RUpkcUdXbFhZWjFQSVhSdzE1a0dkOVFLdUN6bkZnOW9KWS8zQXo0Q1Zueldl?=
 =?utf-8?B?ak95b1BQRnVZbXNGbTVrTElkUXVlWUdRK0RYNEN6MG9pV3k3SkcxYy9zU1Js?=
 =?utf-8?B?RjRYTHJobVVoTkNrVWV6UUFHL2Npbk1yZzh6ZlFGb2JvOTRuMERGSjdPVUIy?=
 =?utf-8?B?eG9ITWl3L2NqQ0cwK0t1OWZpUmU3amRMZ1hEdFNBKzdESGEra24xZHd1VXYz?=
 =?utf-8?B?cHU3akxXNkxpd2RVL0RxaEFrSithbVZZc3cybzkwQmRnYlg5OG5xWTA0Y1Z6?=
 =?utf-8?B?V2R3NWJCYXhLcDhUa2RiNEh1bEdJVmxHajBkdnB0ZFR6Q1pkOHZnMklLcnhS?=
 =?utf-8?B?NlB0Q2ZUR2NTb0lJRVh6bGFjSFVWRGVzRzdIVER5Und2VDlYYmFsM3h1eXFV?=
 =?utf-8?B?dEVEdzlMd2ZFeVhOakRYVGJDM0l2TUc1QWpJRDdSWXh3MXFZVm5rL3RaK1ha?=
 =?utf-8?B?N3RqeWcxeUwwQjJPMnIxMUdaWk8rVlNldGFiTGgyUHNvWXRQQjNQK2RydEdi?=
 =?utf-8?B?ZkllTGgxcHNhdWRQNTdxWnpPOWxTY2VIQUxaV1FUZzkvVG4xQnlDWEpKbUZG?=
 =?utf-8?B?TU91WFp6ZUpRQ0ZZK3JyUloxK1hySDZTUndjMzZjQzJPanBtd2JZMlpQd0V1?=
 =?utf-8?B?a1lxdmhtWXZKbjhjbVl5YVhJSnc4NGNRdUFuMXFYb3VsSU1mbFhlQzMxUVVF?=
 =?utf-8?B?UW5JRlBQblB1R2dwUlJTQXdwc3d1bTV3WG5BUnk2Mnd6WDRKRENDTFI2L2Fo?=
 =?utf-8?B?Z1lpV1AzRmR4aW5FL05PWlpVdmFhZmtSSGY3QT09?=
X-Microsoft-Antispam-Message-Info: eVbpLJ2UghHrZU320ymf12UcTMBxjXbRyoSst79U188Lb/TnvyVq5ycW70mBlP/O1drqctT31rzhd6sykSikmXeTUIA8/KZl5l8BsQR6ibj15v/JPvPjS7iuFxWsKYAj9zqykChMJIPGXeD7xHdTeedeM3s1xUbSt3Sc0znufTdhOxcOk3GtYMgcyUIcy/PHiWrIp89y5F2SFatcGfe67zU7eBy5ZibAjqKPC6W7XLTvh7VXYoTQgSI3CnSwj2sRZXD2BiorylMpSrGQ811D0sLrxEL+1VFz+V/4Vj+vc4iPw2WQw24JsaWAY5EV9/nk6fhjGwdrvN3NavemxkOmtQ==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:279yDKs22PKmpgbXkOK50np+/aJb3jGjeBxH3x264hgnTgIvKpjTy/La5ynOenNIN7QN6LwpCqa//+Ed8MT0kaNopbf84BXNEjrJ4psiv0ihdLXZSJKRmvcoei0MFgF+P6VXqNOEvVkvRnoPryG8FH/gQqBm/ZGlRx3p8+7TBlN4lhV0bte7+AtCcEJ6kybuwdvb9ZfBaWDJDB7KT+82jp3NRGpQHAXi0jTL2lx4nj1GIPyay/rIbDOe2utFAN12bN4mFIfuJ5rVKW73rgOqOkst+yhy6uH6e1T9tabK2bTfziYsLvKBClxQJckxKhoi/orB/gAjXXcPVE1ooryavzNUYhsYCXPqCTuTVd39eZ4+RaIKbZVzehfB7fA3grcVQg9HCQlU+p555wi9Lcr/lZOd/cmTcOuU0sQnLWP2BMoqqLE3bJt9+f5RhY9jWed3EjapqhBVk8eCeS/aIioO0Q==;5:tFIZJLaAyQRbsbbBCuKtVwd6wjYdVITR+PxUivkbLEfh5q8Kr+lqdwdfW+59+ul6r6E732yusweLY7Ja6L6uqSZE06Nb1QWNSJcepnwi78dqoJiXqFBFc/uU/5tu8bOSphm0M2bW1z5+4kw8qkZFrzag7VaYVcmQVTcfOHpQu6A=;24:7TGQWXAcCxc+GA4iFUII7zb1vXMRwgQnNE2yaBVQ7CuasNPtXqkQ054ykGnRWxJtpD+AUkPZ1DFqXh5rYAakOXDdt3q3y0iELWDcrhPEErI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;7:f4lyyt4veL1gTIMzmw6zLMec8Nifi7QelAjUsrdfNdliG7w8wcXaZeUkYLMJKzUjWk+xrhTMq7bZ0KlfHp0lOUbC2toqS0ThgQPPv8iXmy/4sVT/7w0hjdJHXia2z7enVT0G5YmEFrnAJUVNF3956rFUdxUpTAExvkKjmlj49Z9M9sUzwr5faViXXEGCS8ENJ6fbKRsYYQlcL8BubgbM9tB2NgtJyjdrwBQsGOZkj8qVOQBDQbLsvzmmAMPFno5y;20:AlHHUuhOEju3qJBMGmot5IS8BCiUYfiFuS0fH7ybQc7vF+KAPtZJBljwl3mQXrv5lcPpALS9PF0hZh42Np+1a4eANXa4ibOCprUtX9qS+7pxnE3yXQ2MQzf1iy5LRMirVl83IC9Bdt6zM+FCQEE+rpwUkLd+ZwHgJYW1ut+mUhTwWsGHjwXNUqZoTbGwpd+d7kvAGn6yXQHYRZS06BKSnIxleq2kQOjmu8fMDGcd9Y60RCBF4RyksECik5ukPT9L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 15:13:13.1332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25f5291-9497-4351-ea62-08d5d852aef1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

[Adding Felix as well]

Well first of all you have a misconception why at least the AMD graphics 
driver need to be able to sleep in an MMU notifier: We need to sleep 
because we need to wait for hardware operations to finish and *NOT* 
because we need to wait for locks.

I'm not sure if your flag now means that you generally can't sleep in 
MMU notifiers any more, but if that's the case at least AMD hardware 
will break badly. In our case the approach of waiting for a short time 
for the process to be reaped and then select another victim actually 
sounds like the right thing to do.

What we also already try to do is to abort hardware operations with the 
address space when we detect that the process is dying, but that can 
certainly be improved.

Regards,
Christian.

Am 22.06.2018 um 17:02 schrieb Michal Hocko:
> From: Michal Hocko <mhocko@suse.com>
>
> There are several blockable mmu notifiers which might sleep in
> mmu_notifier_invalidate_range_start and that is a problem for the
> oom_reaper because it needs to guarantee a forward progress so it cannot
> depend on any sleepable locks. Currently we simply back off and mark an
> oom victim with blockable mmu notifiers as done after a short sleep.
> That can result in selecting a new oom victim prematurely because the
> previous one still hasn't torn its memory down yet.
>
> We can do much better though. Even if mmu notifiers use sleepable locks
> there is no reason to automatically assume those locks are held.
> Moreover most notifiers only care about a portion of the address
> space. This patch handles the first part of the problem.
> __mmu_notifier_invalidate_range_start gets a blockable flag and
> callbacks are not allowed to sleep if the flag is set to false. This is
> achieved by using trylock instead of the sleepable lock for most
> callbacks. I think we can improve that even further because there is
> a common pattern to do a range lookup first and then do something about
> that. The first part can be done without a sleeping lock I presume.
>
> Anyway, what does the oom_reaper do with all that? We do not have to
> fail right away. We simply retry if there is at least one notifier which
> couldn't make any progress. A retry loop is already implemented to wait
> for the mmap_sem and this is basically the same thing.
>
> Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: Dimitri Sivanich <sivanich@sgi.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86))
> Cc: linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
> Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS)
> Cc: dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
> Cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)
> Cc: linux-rdma@vger.kernel.org (open list:INFINIBAND SUBSYSTEM)
> Cc: xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR INTERFACE)
> Cc: linux-mm@kvack.org (open list:HMM - Heterogeneous Memory Management)
> Reported-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>
> Hi,
> this is an RFC and not tested at all. I am not very familiar with the
> mmu notifiers semantics very much so this is a crude attempt to achieve
> what I need basically. It might be completely wrong but I would like
> to discuss what would be a better way if that is the case.
>
> get_maintainers gave me quite large list of people to CC so I had to trim
> it down. If you think I have forgot somebody, please let me know
>
> Any feedback is highly appreciated.
>
>   arch/x86/kvm/x86.c                      |  7 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  | 33 +++++++++++++++++++------
>   drivers/gpu/drm/i915/i915_gem_userptr.c | 10 +++++---
>   drivers/gpu/drm/radeon/radeon_mn.c      | 15 ++++++++---
>   drivers/infiniband/core/umem_odp.c      | 15 ++++++++---
>   drivers/infiniband/hw/hfi1/mmu_rb.c     |  7 ++++--
>   drivers/misc/mic/scif/scif_dma.c        |  7 ++++--
>   drivers/misc/sgi-gru/grutlbpurge.c      |  7 ++++--
>   drivers/xen/gntdev.c                    | 14 ++++++++---
>   include/linux/kvm_host.h                |  2 +-
>   include/linux/mmu_notifier.h            | 15 +++++++++--
>   mm/hmm.c                                |  7 ++++--
>   mm/mmu_notifier.c                       | 15 ++++++++---
>   mm/oom_kill.c                           | 29 +++++++++++-----------
>   virt/kvm/kvm_main.c                     | 12 ++++++---
>   15 files changed, 137 insertions(+), 58 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6bcecc325e7e..ac08f5d711be 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7203,8 +7203,9 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
>   	kvm_x86_ops->load_eoi_exitmap(vcpu, eoi_exit_bitmap);
>   }
>   
> -void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> -		unsigned long start, unsigned long end)
> +int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> +		unsigned long start, unsigned long end,
> +		bool blockable)
>   {
>   	unsigned long apic_address;
>   
> @@ -7215,6 +7216,8 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>   	apic_address = gfn_to_hva(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
>   	if (start <= apic_address && apic_address < end)
>   		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
> +
> +	return 0;
>   }
>   
>   void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index 83e344fbb50a..d138a526feff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -136,12 +136,18 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
>    *
>    * Take the rmn read side lock.
>    */
> -static void amdgpu_mn_read_lock(struct amdgpu_mn *rmn)
> +static int amdgpu_mn_read_lock(struct amdgpu_mn *rmn, bool blockable)
>   {
> -	mutex_lock(&rmn->read_lock);
> +	if (blockable)
> +		mutex_lock(&rmn->read_lock);
> +	else if (!mutex_trylock(&rmn->read_lock))
> +		return -EAGAIN;
> +
>   	if (atomic_inc_return(&rmn->recursion) == 1)
>   		down_read_non_owner(&rmn->lock);
>   	mutex_unlock(&rmn->read_lock);
> +
> +	return 0;
>   }
>   
>   /**
> @@ -197,10 +203,11 @@ static void amdgpu_mn_invalidate_node(struct amdgpu_mn_node *node,
>    * We block for all BOs between start and end to be idle and
>    * unmap them by move them into system domain again.
>    */
> -static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
> +static int amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>   						 struct mm_struct *mm,
>   						 unsigned long start,
> -						 unsigned long end)
> +						 unsigned long end,
> +						 bool blockable)
>   {
>   	struct amdgpu_mn *rmn = container_of(mn, struct amdgpu_mn, mn);
>   	struct interval_tree_node *it;
> @@ -208,7 +215,11 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>   	/* notification is exclusive, but interval is inclusive */
>   	end -= 1;
>   
> -	amdgpu_mn_read_lock(rmn);
> +	/* TODO we should be able to split locking for interval tree and
> +	 * amdgpu_mn_invalidate_node
> +	 */
> +	if (amdgpu_mn_read_lock(rmn, blockable))
> +		return -EAGAIN;
>   
>   	it = interval_tree_iter_first(&rmn->objects, start, end);
>   	while (it) {
> @@ -219,6 +230,8 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>   
>   		amdgpu_mn_invalidate_node(node, start, end);
>   	}
> +
> +	return 0;
>   }
>   
>   /**
> @@ -233,10 +246,11 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>    * necessitates evicting all user-mode queues of the process. The BOs
>    * are restorted in amdgpu_mn_invalidate_range_end_hsa.
>    */
> -static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
> +static int amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
>   						 struct mm_struct *mm,
>   						 unsigned long start,
> -						 unsigned long end)
> +						 unsigned long end,
> +						 bool blockable)
>   {
>   	struct amdgpu_mn *rmn = container_of(mn, struct amdgpu_mn, mn);
>   	struct interval_tree_node *it;
> @@ -244,7 +258,8 @@ static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
>   	/* notification is exclusive, but interval is inclusive */
>   	end -= 1;
>   
> -	amdgpu_mn_read_lock(rmn);
> +	if (amdgpu_mn_read_lock(rmn, blockable))
> +		return -EAGAIN;
>   
>   	it = interval_tree_iter_first(&rmn->objects, start, end);
>   	while (it) {
> @@ -262,6 +277,8 @@ static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
>   				amdgpu_amdkfd_evict_userptr(mem, mm);
>   		}
>   	}
> +
> +	return 0;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/i915/i915_gem_userptr.c b/drivers/gpu/drm/i915/i915_gem_userptr.c
> index 854bd51b9478..5285df9331fa 100644
> --- a/drivers/gpu/drm/i915/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
> @@ -112,10 +112,11 @@ static void del_object(struct i915_mmu_object *mo)
>   	mo->attached = false;
>   }
>   
> -static void i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
> +static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
>   						       struct mm_struct *mm,
>   						       unsigned long start,
> -						       unsigned long end)
> +						       unsigned long end,
> +						       bool blockable)
>   {
>   	struct i915_mmu_notifier *mn =
>   		container_of(_mn, struct i915_mmu_notifier, mn);
> @@ -124,7 +125,7 @@ static void i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
>   	LIST_HEAD(cancelled);
>   
>   	if (RB_EMPTY_ROOT(&mn->objects.rb_root))
> -		return;
> +		return 0;
>   
>   	/* interval ranges are inclusive, but invalidate range is exclusive */
>   	end--;
> @@ -152,7 +153,8 @@ static void i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
>   		del_object(mo);
>   	spin_unlock(&mn->lock);
>   
> -	if (!list_empty(&cancelled))
> +	/* TODO: can we skip waiting here? */
> +	if (!list_empty(&cancelled) && blockable)
>   		flush_workqueue(mn->wq);
>   }
>   
> diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
> index abd24975c9b1..b47e828b725d 100644
> --- a/drivers/gpu/drm/radeon/radeon_mn.c
> +++ b/drivers/gpu/drm/radeon/radeon_mn.c
> @@ -118,10 +118,11 @@ static void radeon_mn_release(struct mmu_notifier *mn,
>    * We block for all BOs between start and end to be idle and
>    * unmap them by move them into system domain again.
>    */
> -static void radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
> +static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
>   					     struct mm_struct *mm,
>   					     unsigned long start,
> -					     unsigned long end)
> +					     unsigned long end,
> +					     bool blockable)
>   {
>   	struct radeon_mn *rmn = container_of(mn, struct radeon_mn, mn);
>   	struct ttm_operation_ctx ctx = { false, false };
> @@ -130,7 +131,13 @@ static void radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
>   	/* notification is exclusive, but interval is inclusive */
>   	end -= 1;
>   
> -	mutex_lock(&rmn->lock);
> +	/* TODO we should be able to split locking for interval tree and
> +	 * the tear down.
> +	 */
> +	if (blockable)
> +		mutex_lock(&rmn->lock);
> +	else if (!mutex_trylock(&rmn->lock))
> +		return -EAGAIN;
>   
>   	it = interval_tree_iter_first(&rmn->objects, start, end);
>   	while (it) {
> @@ -167,6 +174,8 @@ static void radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
>   	}
>   	
>   	mutex_unlock(&rmn->lock);
> +
> +	return 0;
>   }
>   
>   static const struct mmu_notifier_ops radeon_mn_ops = {
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index 182436b92ba9..f65f6a29daae 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -207,22 +207,29 @@ static int invalidate_range_start_trampoline(struct ib_umem *item, u64 start,
>   	return 0;
>   }
>   
> -static void ib_umem_notifier_invalidate_range_start(struct mmu_notifier *mn,
> +static int ib_umem_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   						    struct mm_struct *mm,
>   						    unsigned long start,
> -						    unsigned long end)
> +						    unsigned long end,
> +						    bool blockable)
>   {
>   	struct ib_ucontext *context = container_of(mn, struct ib_ucontext, mn);
>   
>   	if (!context->invalidate_range)
> -		return;
> +		return 0;
> +
> +	if (blockable)
> +		down_read(&context->umem_rwsem);
> +	else if (!down_read_trylock(&context->umem_rwsem))
> +		return -EAGAIN;
>   
>   	ib_ucontext_notifier_start_account(context);
> -	down_read(&context->umem_rwsem);
>   	rbt_ib_umem_for_each_in_range(&context->umem_tree, start,
>   				      end,
>   				      invalidate_range_start_trampoline, NULL);
>   	up_read(&context->umem_rwsem);
> +
> +	return 0;
>   }
>   
>   static int invalidate_range_end_trampoline(struct ib_umem *item, u64 start,
> diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
> index 70aceefe14d5..8780560d1623 100644
> --- a/drivers/infiniband/hw/hfi1/mmu_rb.c
> +++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
> @@ -284,10 +284,11 @@ void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
>   	handler->ops->remove(handler->ops_arg, node);
>   }
>   
> -static void mmu_notifier_range_start(struct mmu_notifier *mn,
> +static int mmu_notifier_range_start(struct mmu_notifier *mn,
>   				     struct mm_struct *mm,
>   				     unsigned long start,
> -				     unsigned long end)
> +				     unsigned long end,
> +				     bool blockable)
>   {
>   	struct mmu_rb_handler *handler =
>   		container_of(mn, struct mmu_rb_handler, mn);
> @@ -313,6 +314,8 @@ static void mmu_notifier_range_start(struct mmu_notifier *mn,
>   
>   	if (added)
>   		queue_work(handler->wq, &handler->del_work);
> +
> +	return 0;
>   }
>   
>   /*
> diff --git a/drivers/misc/mic/scif/scif_dma.c b/drivers/misc/mic/scif/scif_dma.c
> index 63d6246d6dff..d940568bed87 100644
> --- a/drivers/misc/mic/scif/scif_dma.c
> +++ b/drivers/misc/mic/scif/scif_dma.c
> @@ -200,15 +200,18 @@ static void scif_mmu_notifier_release(struct mmu_notifier *mn,
>   	schedule_work(&scif_info.misc_work);
>   }
>   
> -static void scif_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> +static int scif_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   						     struct mm_struct *mm,
>   						     unsigned long start,
> -						     unsigned long end)
> +						     unsigned long end,
> +						     bool blockable)
>   {
>   	struct scif_mmu_notif	*mmn;
>   
>   	mmn = container_of(mn, struct scif_mmu_notif, ep_mmu_notifier);
>   	scif_rma_destroy_tcw(mmn, start, end - start);
> +
> +	return 0
>   }
>   
>   static void scif_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
> diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
> index a3454eb56fbf..be28f05bfafa 100644
> --- a/drivers/misc/sgi-gru/grutlbpurge.c
> +++ b/drivers/misc/sgi-gru/grutlbpurge.c
> @@ -219,9 +219,10 @@ void gru_flush_all_tlb(struct gru_state *gru)
>   /*
>    * MMUOPS notifier callout functions
>    */
> -static void gru_invalidate_range_start(struct mmu_notifier *mn,
> +static int gru_invalidate_range_start(struct mmu_notifier *mn,
>   				       struct mm_struct *mm,
> -				       unsigned long start, unsigned long end)
> +				       unsigned long start, unsigned long end,
> +				       bool blockable)
>   {
>   	struct gru_mm_struct *gms = container_of(mn, struct gru_mm_struct,
>   						 ms_notifier);
> @@ -231,6 +232,8 @@ static void gru_invalidate_range_start(struct mmu_notifier *mn,
>   	gru_dbg(grudev, "gms %p, start 0x%lx, end 0x%lx, act %d\n", gms,
>   		start, end, atomic_read(&gms->ms_range_active));
>   	gru_flush_tlb_range(gms, start, end - start);
> +
> +	return 0;
>   }
>   
>   static void gru_invalidate_range_end(struct mmu_notifier *mn,
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index bd56653b9bbc..50724d09fe5c 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -465,14 +465,20 @@ static void unmap_if_in_range(struct grant_map *map,
>   	WARN_ON(err);
>   }
>   
> -static void mn_invl_range_start(struct mmu_notifier *mn,
> +static int mn_invl_range_start(struct mmu_notifier *mn,
>   				struct mm_struct *mm,
> -				unsigned long start, unsigned long end)
> +				unsigned long start, unsigned long end,
> +				bool blockable)
>   {
>   	struct gntdev_priv *priv = container_of(mn, struct gntdev_priv, mn);
>   	struct grant_map *map;
>   
> -	mutex_lock(&priv->lock);
> +	/* TODO do we really need a mutex here? */
> +	if (blockable)
> +		mutex_lock(&priv->lock);
> +	else if (!mutex_trylock(&priv->lock))
> +		return -EAGAIN;
> +
>   	list_for_each_entry(map, &priv->maps, next) {
>   		unmap_if_in_range(map, start, end);
>   	}
> @@ -480,6 +486,8 @@ static void mn_invl_range_start(struct mmu_notifier *mn,
>   		unmap_if_in_range(map, start, end);
>   	}
>   	mutex_unlock(&priv->lock);
> +
> +	return true;
>   }
>   
>   static void mn_release(struct mmu_notifier *mn,
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4ee7bc548a83..e4181063e755 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1275,7 +1275,7 @@ static inline long kvm_arch_vcpu_async_ioctl(struct file *filp,
>   }
>   #endif /* CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL */
>   
> -void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> +int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>   		unsigned long start, unsigned long end);
>   
>   #ifdef CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 392e6af82701..369867501bed 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -230,7 +230,8 @@ extern int __mmu_notifier_test_young(struct mm_struct *mm,
>   extern void __mmu_notifier_change_pte(struct mm_struct *mm,
>   				      unsigned long address, pte_t pte);
>   extern void __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> -				  unsigned long start, unsigned long end);
> +				  unsigned long start, unsigned long end,
> +				  bool blockable);
>   extern void __mmu_notifier_invalidate_range_end(struct mm_struct *mm,
>   				  unsigned long start, unsigned long end,
>   				  bool only_end);
> @@ -281,7 +282,17 @@ static inline void mmu_notifier_invalidate_range_start(struct mm_struct *mm,
>   				  unsigned long start, unsigned long end)
>   {
>   	if (mm_has_notifiers(mm))
> -		__mmu_notifier_invalidate_range_start(mm, start, end);
> +		__mmu_notifier_invalidate_range_start(mm, start, end, true);
> +}
> +
> +static inline int mmu_notifier_invalidate_range_start_nonblock(struct mm_struct *mm,
> +				  unsigned long start, unsigned long end)
> +{
> +	int ret = 0;
> +	if (mm_has_notifiers(mm))
> +		ret = __mmu_notifier_invalidate_range_start(mm, start, end, false);
> +
> +	return ret;
>   }
>   
>   static inline void mmu_notifier_invalidate_range_end(struct mm_struct *mm,
> diff --git a/mm/hmm.c b/mm/hmm.c
> index de7b6bf77201..81fd57bd2634 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -177,16 +177,19 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	up_write(&hmm->mirrors_sem);
>   }
>   
> -static void hmm_invalidate_range_start(struct mmu_notifier *mn,
> +static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>   				       struct mm_struct *mm,
>   				       unsigned long start,
> -				       unsigned long end)
> +				       unsigned long end,
> +				       bool blockable)
>   {
>   	struct hmm *hmm = mm->hmm;
>   
>   	VM_BUG_ON(!hmm);
>   
>   	atomic_inc(&hmm->sequence);
> +
> +	return 0;
>   }
>   
>   static void hmm_invalidate_range_end(struct mmu_notifier *mn,
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index eff6b88a993f..30cc43121da9 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -174,18 +174,25 @@ void __mmu_notifier_change_pte(struct mm_struct *mm, unsigned long address,
>   	srcu_read_unlock(&srcu, id);
>   }
>   
> -void __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> -				  unsigned long start, unsigned long end)
> +int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> +				  unsigned long start, unsigned long end,
> +				  bool blockable)
>   {
>   	struct mmu_notifier *mn;
> +	int ret = 0;
>   	int id;
>   
>   	id = srcu_read_lock(&srcu);
>   	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist) {
> -		if (mn->ops->invalidate_range_start)
> -			mn->ops->invalidate_range_start(mn, mm, start, end);
> +		if (mn->ops->invalidate_range_start) {
> +			int _ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
> +			if (_ret)
> +				ret = _ret;
> +		}
>   	}
>   	srcu_read_unlock(&srcu, id);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range_start);
>   
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 84081e77bc51..7e0c6e78ae5c 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -479,9 +479,10 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
>   static struct task_struct *oom_reaper_list;
>   static DEFINE_SPINLOCK(oom_reaper_lock);
>   
> -void __oom_reap_task_mm(struct mm_struct *mm)
> +bool __oom_reap_task_mm(struct mm_struct *mm)
>   {
>   	struct vm_area_struct *vma;
> +	bool ret = true;
>   
>   	/*
>   	 * Tell all users of get_user/copy_from_user etc... that the content
> @@ -511,12 +512,17 @@ void __oom_reap_task_mm(struct mm_struct *mm)
>   			struct mmu_gather tlb;
>   
>   			tlb_gather_mmu(&tlb, mm, start, end);
> -			mmu_notifier_invalidate_range_start(mm, start, end);
> +			if (mmu_notifier_invalidate_range_start_nonblock(mm, start, end)) {
> +				ret = false;
> +				continue;
> +			}
>   			unmap_page_range(&tlb, vma, start, end, NULL);
>   			mmu_notifier_invalidate_range_end(mm, start, end);
>   			tlb_finish_mmu(&tlb, start, end);
>   		}
>   	}
> +
> +	return ret;
>   }
>   
>   static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
> @@ -545,18 +551,6 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>   		goto unlock_oom;
>   	}
>   
> -	/*
> -	 * If the mm has invalidate_{start,end}() notifiers that could block,
> -	 * sleep to give the oom victim some more time.
> -	 * TODO: we really want to get rid of this ugly hack and make sure that
> -	 * notifiers cannot block for unbounded amount of time
> -	 */
> -	if (mm_has_blockable_invalidate_notifiers(mm)) {
> -		up_read(&mm->mmap_sem);
> -		schedule_timeout_idle(HZ);
> -		goto unlock_oom;
> -	}
> -
>   	/*
>   	 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
>   	 * work on the mm anymore. The check for MMF_OOM_SKIP must run
> @@ -571,7 +565,12 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>   
>   	trace_start_task_reaping(tsk->pid);
>   
> -	__oom_reap_task_mm(mm);
> +	/* failed to reap part of the address space. Try again later */
> +	if (!__oom_reap_task_mm(mm)) {
> +		up_read(&mm->mmap_sem);
> +		ret = false;
> +		goto out_unlock;
> +	}
>   
>   	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
>   			task_pid_nr(tsk), tsk->comm,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index ada21f47f22b..6f7e709d2944 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -135,7 +135,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm);
>   static unsigned long long kvm_createvm_count;
>   static unsigned long long kvm_active_vms;
>   
> -__weak void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> +__weak int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>   		unsigned long start, unsigned long end)
>   {
>   }
> @@ -354,13 +354,15 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
>   	srcu_read_unlock(&kvm->srcu, idx);
>   }
>   
> -static void kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> +static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   						    struct mm_struct *mm,
>   						    unsigned long start,
> -						    unsigned long end)
> +						    unsigned long end,
> +						    bool blockable)
>   {
>   	struct kvm *kvm = mmu_notifier_to_kvm(mn);
>   	int need_tlb_flush = 0, idx;
> +	int ret;
>   
>   	idx = srcu_read_lock(&kvm->srcu);
>   	spin_lock(&kvm->mmu_lock);
> @@ -378,9 +380,11 @@ static void kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   
>   	spin_unlock(&kvm->mmu_lock);
>   
> -	kvm_arch_mmu_notifier_invalidate_range(kvm, start, end);
> +	ret = kvm_arch_mmu_notifier_invalidate_range(kvm, start, end, blockable);
>   
>   	srcu_read_unlock(&kvm->srcu, idx);
> +
> +	return ret;
>   }
>   
>   static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,

