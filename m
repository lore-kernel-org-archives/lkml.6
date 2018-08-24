Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698BBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A322157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uLtIBM7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A322157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHXQ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:28:28 -0400
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:18311
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbeHXQ21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOYaISP2RjdWyLnwG70Kc3IXYTmOGGRyC2ZNb6yNfv4=;
 b=uLtIBM7c6AGJou+RhUYzPR3IR2veu5blap+WXUbmFHT4vNt2JaHD8I6BjNnVoANjo4vvIv+04Fur94APlitpe7vL4pBYmNFlafbpL9ob6IYHDjj2JSCSpimv3F1MAYkFxq7XaYq3aC1OnUT1RP8FeM1AX79ikHaxOMtY6FiV6h0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 BN6PR12MB1716.namprd12.prod.outlook.com (2603:10b6:404:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Fri, 24 Aug
 2018 12:52:37 +0000
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Doug Ledford <dledford@redhat.com>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <felix.kuehling@amd.com>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
 <20180824113248.GH29735@dhcp22.suse.cz>
 <b088e382-e90e-df63-a079-19b2ae2b985d@gmail.com>
 <20180824115226.GK29735@dhcp22.suse.cz>
 <a27ad1a3-34bd-6b7d-fd09-7737ec3c888d@gmail.com>
 <20180824120339.GL29735@dhcp22.suse.cz>
 <eb546bcb-9c5f-7d5d-43a7-bfde489f0e7f@amd.com>
 <20180824123341.GN29735@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b11df415-baf8-0a41-3c16-60dfe8d32bd3@amd.com>
Date:   Fri, 24 Aug 2018 14:52:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824123341.GN29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR05CA0161.eurprd05.prod.outlook.com
 (2603:10a6:7:28::48) To BN6PR12MB1716.namprd12.prod.outlook.com
 (2603:10b6:404:106::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79530431-447d-48fb-9325-08d609c07d2e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1716;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;3:8dTvmSmF/Mte9M6YP4z2G7W6mpKaxgba43xMacl+ni7WLhEvuPd9cPevyHJ67/QHQlBDVNODLiBlX0n0kNx6qgwSaWGypEUwUMBwkiALirJaRZ7K6P0bDwQJgkR7bvlZ/GU9ndDkQw8esf1S8jjyNIW3+YjQz4nhOXc87wXPHs5df7ZTDizjiePd20GvP6mrktCenmlcLqPgR3p3MEQFFdHnQFsMmA5bk/vTtWkJ2fJL8E25yWUT0+yZmcyRjFXw;25:57cG2fKCXH1BO2MGj8gwYYW6srfhtTMAYMDuF3fBq70rhk7GpYWa/YrIiAulVuDUMNgpLdN+zGNZdxMJGiRb013JLi7xt06DmI27D3LweGOKyOP4+U8TgTrKNjPYlR6Csao7v7NSnTWUKU0sedbafRZTMaO2TOTh2WbJmLBoaZkGInjWFytrhXjIhfu3Vv3a4+HCPDYU80k7lleM8fRTROzwwdBowwmjPY4mLircSaA2cmsQZTPCB/i0NYXdOb5+K2TI1Xint49iTWVwihKaSvu+yR/As886K9z/HgaGeEM7aPNbw9ehF6wqFoPS5GfHiLyl9Yjt7R9lzkHhV68sLQ==;31:UZka8gmeXWRKuSD9RbgIHN0vrqo1bcnHeyFBgzUU2qIohWko1bLCs6zzBb+OIKeeKbwTuuoz0NuQUNBRbsRPbBgLGYTom01k6rxHzPF+rkT0DIGdEoBInt3KDN4kFyUUT9z296MsvQGiX0ChoH5E+CYMZjUIEsK63R4ERSBX9Z4xUnV1GTgKpSR+sqJqKzR258WVaSlhJbZDhdCnf4WiesOvA+GXyPLkv9TJ8t5dX1c=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1716:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;20:18928vbciYnexP4UOaNM2B0bdvNy3xKTwQ2jVZhMsebuVkoRLh19y5uHudH9YzyH0vaiFhMm1PSjFK0ImHezi3pAFRqhqpJZ/BiuN4+LPPAJavqzYNXl3i+SUQ16PpC/n4fPs3ignRSe+fMFtY1toBqQ0ISbERIPeN7IFryvhTUidXnV7+f0dhw0qXoVCD1iV8J0zEe/DMrMF3smQxBVxDcoxJv8pNRWhESzc5iWh5CDh21TJLDM0xCMEiSikA6KKy9ASIIYoU2GmO2WpMoxzDLhqplQ7m78ZN7tZP4SDd7OzpGpYIXlLewg89hM64om3daem9aegm+6X7/nY0DNCk0qcXCLrzHp7vX3vP4M6EXdqFtLoSvBr/u8HULfrmxQNhbS6EuyaDa4cNCfWp9hik6axYAMyU29WeBL7jWXWYAP9GtxPlG6Z8+GbxprIGxc0fVq4QHKGinAgRvd65LJ24VyBciZWMDveQEBsizVJKwRmXLMIFUQuabA7znlpVQw;4:47qwvD97ngoqV1cupBJIvffdmUYfC/2HvrXD/6Sda9DT6dPbaQIarAEYiAtR1VnvYka7SXNAWp3LSjisHRW9ZtY1Y/tHc2XVfqrbSjdMWmDRjppWviEh39rdufHHRWmh7RB/HRQOPzQTZqt9BrBJ910iLAh8VmciI7Nt8X5Dq2IeT8BHB+Aog7MtCCJWAag0T8f+Fy0vpCIcfCPXSamPjUWedk9b2Alcn2RJDMpnEi6FymsWUxzgCf+4oJ5xS/rTnKhNWzUZEqZIhHpHDzf5SA==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1716B8130C0AEA8DE91D049883360@BN6PR12MB1716.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BN6PR12MB1716;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1716;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39860400002)(55674003)(199004)(189003)(4326008)(58126008)(6666003)(52146003)(46003)(97736004)(53936002)(8676002)(54906003)(110136005)(316002)(386003)(25786009)(81156014)(229853002)(81166006)(16526019)(47776003)(36756003)(1706002)(7736002)(305945005)(11346002)(86362001)(105586002)(93886005)(65806001)(486006)(23676004)(65956001)(2616005)(476003)(446003)(6116002)(2486003)(6246003)(106356001)(5660300001)(72206003)(8936002)(52396003)(31686004)(68736007)(76176011)(50466002)(6486002)(2906002)(7406005)(7416002)(64126003)(67846002)(52116002)(65826007)(2870700001)(14444005)(31696002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1716;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE2OzIzOk52L3lCRDkySnVYNWZ0dG44dWpvYkRVbE00?=
 =?utf-8?B?VG9RR1RvNEVJRzk0UVlSMDh1bERjMGgxM1ZOdm9VdE9KZ2d1WGRNKzdWTTNl?=
 =?utf-8?B?akNlM3ByQjhRa2lhMEZvdndQaGdJSHNmbXdTOWJXNDJGZnJSdUM2d0ZiekpH?=
 =?utf-8?B?OXlobWhTVnNLci9MYk9BTURISWk4bTBNdVNRSi9XRmQyOFNXVGRzVks4d1g2?=
 =?utf-8?B?NmtjN2ozTWpEb2VEY3E3ZUFRNlJkT3NwRWFUaFRocEFqSWF0K2E0N2VvZUgz?=
 =?utf-8?B?UjI3bDBhUVVvZ1IwSG9kUW9ndDE5L3Z2UGgyQTUwQVlSMDhQKzN0UWdJU2w3?=
 =?utf-8?B?UytZVk1KSUpNS3F1K2ZpeU9vVTlWRlRKZWVLbzBJL1ErN1dYcEpWeERZNVZ3?=
 =?utf-8?B?aytrVHY5b2xraERRTzZrYzNTa0Y2VzFzV1UzY3QycndsdmRXc1c0dVltdEIr?=
 =?utf-8?B?SnhQaUwzWTBtY2ZqTVZTUkR0Tk9qbG91U0o1YnRDUlV6bmpuSUhWbGhtK0U0?=
 =?utf-8?B?QVF5SnQwMDJ4anMyMWY1dk4xU3Y3MGNRWG5wNzcwZ2lCRHhDOGluQzNwV3d0?=
 =?utf-8?B?MTBDSVNKNXpDZWZUT1F1bklEYm1WQisreWR3NmtaeTlFQ2J2UnNpSHh6ZlZk?=
 =?utf-8?B?WXdMK3RXT0NKMjVVQit2WkFRYXlxWHJ1blA4NHdiWUdVc0Qra3B5TkdvUS8v?=
 =?utf-8?B?UVlveEtLK2x3MWNnK3hOaWdOSVl3SXJHK2pmb0k1UTNXa1lqRjQxb2xPcXRr?=
 =?utf-8?B?cUZIeGROUDVPdE9TcGlpQ1p1R1V4VGZsY0FtMjBuSmVxWVhLdUNTaURKQ1Np?=
 =?utf-8?B?WFJqeFptR0dsVDd4eUdDbXpzYmVXcm5mZ09kbmNKU2pXRWRXYjZVM29oTlMw?=
 =?utf-8?B?Q1Z2Qll3TFFWdEFKaTBiYWdka0pldzZxQll2ZTdaNTlnYkxrK001Sm1FT1B0?=
 =?utf-8?B?NzJQbVRzR0ZrQUZ1YmdRUmFEQ0gyUkQwWnczaTdqenlUbmRMKzRweGx2MEZK?=
 =?utf-8?B?bTV4aVNZV3cxOTVaN0FSRVJVUm50WEFvK0lmbmlmcllOQXUvM0o5eXVsc01I?=
 =?utf-8?B?MkJjaWJ6SHljdExZMkRYOXJSUFo3bFBlOU5jblpJLzh4dFlta0FXN3FWbEs5?=
 =?utf-8?B?N0VJSXg3NXROc0M3ckZyTlNPNXl4d1gvZTZIMHA5c1d1SHY3WmpQYWowNm0x?=
 =?utf-8?B?THpnRDJvZmJMK0F4RGdvbjk2eUpjUzhUZDdkT1Rua1lqT0czY3l4U29TZlNq?=
 =?utf-8?B?aTREYVJtcWYyMWZsbVhXSHRjdTZWWUkvWlRFeDFXTk84QnU2RzN0azZrazJR?=
 =?utf-8?B?VzJUcUlPQkRzKzJtY3lsSnk5ZDdrODhnRkp0RGZFNWxUVFpGSnQycEJqOFla?=
 =?utf-8?B?N0tJL2RDMHhveTUyTC9pMjF5WnNNbGRsSEd0alNRaktOYzFQTkt2djVvaDZz?=
 =?utf-8?B?TkVJR1R1Yy8vakpqMkV6enBXSXJINmRjdzZhbHovVDdXMmhNU0E2Q3V2dWhv?=
 =?utf-8?B?ZXNRdWZ5NlB5LzdNVVRTZVk5YzdWQW1ObmJ0V0JMMXkvLytveEdtMzNQekN5?=
 =?utf-8?B?SGFMV01MSnVGZVd2ZDB2OHpwZjFJV2NQN3pxRnN1cHZqWGtZb0lYSHNKWDBm?=
 =?utf-8?B?NzZSaERmSkV2OEpaTVE1MnVEYjlzdUpxb292Nk5WQW55eFdPcGlHUmJTa0E1?=
 =?utf-8?B?ckQvZFpuTDk3b2VVaVNqbWlQT205NDJQNjJNNXB1V3FGTVlKZm9URU9qa056?=
 =?utf-8?B?UzJUKzd2N3dEY0pzcFAxNkZ5K2tiMGpDWWsvblVGUCtWZDFLM2ppRHNRYU4r?=
 =?utf-8?B?YWhJMm5hZUJmUDNRZm1yUHhWQlZrRUNxaUp1UG5jTkc2bGJsdFhzTURPNEZz?=
 =?utf-8?B?ZXdzczFBR1g0UW90akZoYVJocmtmRkd5Y0R0bGw4Snp1SUNFQ3lwVTRicGNG?=
 =?utf-8?B?cDgvZVVYaFRQVVNLSjJHeGZxa0gvRkRFLytPblF3RXg2Y01nZmRwdE11YXZm?=
 =?utf-8?Q?V4wOUZ?=
X-Microsoft-Antispam-Message-Info: JYfR62vZenETaKeWewnoRjeSB7ccie3CtLE2bJzq96q8MV2oFWacdirBkdaUuGOrwl28f5yMjkkSypnMSg4rgzAEG1uJI3HiUOzjj1w3C21tknFftqf25sYEHx6Wj1AcwwD16nmpSjseSwIUjkK46ob/LuRfby0JQDr7BKCxpStKCBZN6tzra6qiCmd/YthyGJ0c3NkPg1BJE0xS02Fpv03G9DVl+gNIGqgDJWmJAbyv/SFdc2dw/HmSa+t7IfeeoDvqQyzXIyAGCJs0Y5CBGqLD1a92DepIA2spkylP3JHuLwtxMI68BGnRkUp8a0B5gcF+v7RSeyNhnLd5pDh+4aEVYdM+vIGRLCdkGr5vyu8=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;6:FGRgqrFg7+auqWxoBYV9o+ncu1PZkwFXhbR3GaqJbW4DECfb9X2HHSIYHlW/FuU4Z6nENq3nIGd6SvwAFopDoDRnVg+JFIk0RBAAh8rgycGuWJrhpmDriiIdcfznkV0LKEQRd9wU/2I/d7r7h92bGGmx98iKkoPRXNVHXB2pi3rd036atG5pFribX0Tds9rhg6XP7Cd1e3ud1rmEuAkOH/uMH3nXmkNwf7F8UqR6IzS7dR89hjmHKeydmRqnB39KLjNHUgIIRZy1H0/fv3veMRoLy0CqQ3gixfAtMpz/OS/tCXLATACB0S4r71GoEaqCGDrgMXvZ/S6eupAjIC4ItynkaRef2IYs8c1D9wDwILnNUa1ezWckpGFIokm8L9hIPCetogTK1ukmQYEd2U4jt4wDUb6Q9/2wJNIg64SghgFhcMdUuKxJuN2c97SH1wuFOf5bR9lyNZnUL9zgTzND/A==;5:KzZ/2BhgTarNas3eAsh5BZmkDnrPOXvB9+tyaH56oORsPHcx84JGWipU5ONMjwfaGBn+mc/mgyZ3C4kQa0gHe+/AYLhePCOvlK7DAk9zQAnFcqx/MVnXirLaE/RoihZosv3USQOvNo4XGGz5/6TGOFRyVXyHomL6uSPrYiXuF6M=;7:PaT7dL3qnIvCSMLiuHKi+/58apoAjqyyldIEJAaP/qyJELHnjNPgGekSrDd8DzvcnL3OWLfX76MbWyCjdHEAWeMVQgUaXQpBhU7ojOUOaoa2tzO2iujPubzBItgzs8YPlqTzropbHUtvdlayfdtnXfdJFl5Cqi/t89gKjE0apww6AQt0WYNBa2RDYKo6K8lnX+Ui9A882m+bOQQhqd9V4MgGTs6GVroyX3LhSariHlOBpKutmPWQyQyX5Jg2EuNx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;20:nKeQaCDXO17EaTiC4CX/VhQkKUm7Z1eCt9vDqsr4aocg6rLX+9OWoUZm96XjLnL9UmKaPRoGfuf19Rrq63v/PFK41iRYCSL2mGbfKJV89yWqdTSPCqa63M97GgR0fQ+WAmddvPlGZNhwIO/HJSXdYZbINcDQZ7Ag0xwgzR0XyMFg7GvXGIpgKy3j9LHurP6FuTypH784uudQFglmg900/2+oIvTahmqa7dASInAAOMbcITNYKTp3sOmgIM2VyzTr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 12:52:37.2307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79530431-447d-48fb-9325-08d609c07d2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.08.2018 um 14:33 schrieb Michal Hocko:
> On Fri 24-08-18 14:18:44, Christian König wrote:
>> Am 24.08.2018 um 14:03 schrieb Michal Hocko:
>>> On Fri 24-08-18 13:57:52, Christian König wrote:
>>>> Am 24.08.2018 um 13:52 schrieb Michal Hocko:
>>>>> On Fri 24-08-18 13:43:16, Christian König wrote:
>>> [...]
>>>>>> That won't work like this there might be multiple
>>>>>> invalidate_range_start()/invalidate_range_end() pairs open at the same time.
>>>>>> E.g. the lock might be taken recursively and that is illegal for a
>>>>>> rw_semaphore.
>>>>> I am not sure I follow. Are you saying that one invalidate_range might
>>>>> trigger another one from the same path?
>>>> No, but what can happen is:
>>>>
>>>> invalidate_range_start(A,B);
>>>> invalidate_range_start(C,D);
>>>> ...
>>>> invalidate_range_end(C,D);
>>>> invalidate_range_end(A,B);
>>>>
>>>> Grabbing the read lock twice would be illegal in this case.
>>> I am sorry but I still do not follow. What is the context the two are
>>> called from?
>> I don't have the slightest idea.
>>
>>> Can you give me an example. I simply do not see it in the
>>> code, mostly because I am not familiar with it.
>> I'm neither.
>>
>> We stumbled over that by pure observation and after discussing the problem
>> with Jerome came up with this solution.
>>
>> No idea where exactly that case comes from, but I can confirm that it indeed
>> happens.
> Thiking about it some more, I can imagine that a notifier callback which
> performs an allocation might trigger a memory reclaim and that in turn
> might trigger a notifier to be invoked and recurse. But notifier
> shouldn't really allocate memory. They are called from deep MM code
> paths and this would be extremely deadlock prone. Maybe Jerome can come
> up some more realistic scenario. If not then I would propose to simplify
> the locking here. We have lockdep to catch self deadlocks and it is
> always better to handle a specific issue rather than having a code
> without a clear indication how it can recurse.

Well I agree that we should probably fix that, but I have some concerns 
to remove the existing workaround.

See we added that to get rid of a real problem in a customer environment 
and I don't want to that to show up again.

In the meantime I've send out a fix to avoid allocating memory while 
holding the mn_lock.

Thanks for pointing that out,
Christian.
