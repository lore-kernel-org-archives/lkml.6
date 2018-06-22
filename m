Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D62C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493FA24868
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bVhURRct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493FA24868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeFVUJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:09:25 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:17745
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751342AbeFVUJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZrIbZiegCB2HST9GVCzIoFrcjKLY/Av9+muC7bJbKY=;
 b=bVhURRctrM+wugTiI/vRUlDjGMwA86V6npRJsq/SvMWn5BqRq2jPQkIhbP1VmUVZZ9MsKywA6EEs7WAm1apGASXwef6a23WHev9LCABsPXIqYZizLvLfr2v5z5hk8emTuqxo+VjOO1Gp0xGglRWcp4hdDQwlUjuVgbEOWjf1nc4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from [172.27.224.40] (165.204.55.251) by
 DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Fri, 22 Jun 2018 20:09:12 +0000
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        David Rientjes <rientjes@google.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <0aa9f695-5702-6704-9462-7779cbfdb3fd@amd.com>
 <20180622152444.GC10465@dhcp22.suse.cz>
From:   Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <dd260800-6457-f3ff-47df-b65ef258f4b7@amd.com>
Date:   Fri, 22 Jun 2018 16:09:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622152444.GC10465@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be2fbcb7-5397-486e-de04-08d5d87c072b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1705;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1705;3:jUpIbYy7NgDyW2CgFr9DbUWqWs1eWFPXmdrKJKt+Iv2SjF7kvASoi4q3yBNFf9XoHaIYY1Zbay/6/z3RQ1oMbH2qrDlW/RiNyOUsS/KBv/yb14g85p3qZmxf3TVt0zwxkV3ExTpi/ZICOYqe+4u6DTQkNGxNH5EQ5aApD3icisR3nzFEYcHnrmUm7G0uQs6hy/gWtCSFARLNLr8s4M7K0hQhzrbirmSp2U2avjyE0COFJ1+Xvef5esa1xb9l2OYJ;25:M3q+DQ6hDb29P6SvXiL0ftEw4n9eN078bXj80K0jzkLtqWZuMvrpgy+XtW/IS0FBfUNAWd8nYY4X9B/tuZ1uO3Hm/w0vux5OGWmGPB6+r4dv/XRIsQYdMemLKsPHbB8ssmeYeVRLPHNfSWbXAbYSSRBjcC8/PVWYor+oMAkHZWQJqePUCgoQ/QsRVVTzBPwLvO/GWeSOI7l8gjNki7cy79Ejb//pw/g+VqdjELDQFeRwyVchdFTrpbTMKt2/nHgbMqyxP/F0UPljYXzZOxR+ICkIOSpYhjRB7J7stm80rDOkmf48rvjfYBgB3s73tYff7g6TKChuIBqIzDa3sB0WYA==;31:9VCPlE/sWBhHw0cidR0vIUc9HLG4GM4jkAOqWfzzikfZlhje5XcfLHttL85waQP6Gq8QtOhsQL+iHJWw+3HDo4/g3qHFSMvxRlJgxZoCK55Y7VkHXNbwiedO+3RxGTemYgY1pCinpP8DUbrPmJuDMdLU+szFh9x9xYrTZ8gIhj54JLqAN/HfwJixuczG1wKtTBRzcIPl9nHDg+22yBPh1+PyIjgI6BEgem+xAALtIYs=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1705:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1705;20:mBVszNc5vDnlXD8e7N6oeWjpitIwf/hlEhPrHPnabdPtX7pSbPbPnUTMufg2gpJ2pI7W3xmzTx8GxQULWgsGzlV0/YM4klnaq7AZnsXpY/ivzREpuThwsla+524C805jl/5xJkKncdW9MhdlaOL3JgnnAZBeAZEIYUwXY8SC1Cy7Fgp8GrSPpoXT+r3gId70B46nvI9Jm8zGAlYv5TTVyyRpcf7oyl/DHVtaSL3yVvgxk2+pCnTVpXr6jwfkhTgcEh/KdpRmx7i0G5tyBTwA1JzGKLjwiSQFLlQsCRWgwdnHAp+TvavCdxSeew8ttnO/J7vu9a8guQivxz2EdznfjRjkhr6iDXL++IVmNk1JkaTlrNA1D6+5DFKa9P3m8dh1J7KT1f/L/oojbwdgzcdafMSrEbKXaCUdN5UOGLF05+DnHELIdyyix288Zkhxlsn/JIZ62uZxBP8s22CglPA22+lwCjAH9tGbil6lvj9sQT4urmeWFfe+9x69J2tKI2DU;4:p0cbQPETAT5vHgkb5G1wHruBj6jm2aTO0zUp4/eYj4Lvoj0vuxMcm9E+T/96lNLksU8CigxMCfL+KQVisROyqS3ERFZJXHEBk22Zthk2JqFEPq4POBVjsfLqYxG68WzSzzP+oAhG76GNcjuGPCCviV7g8gAl0GMFFvCSceNsbgD44GJogLmi6xcxnFw6zH07b7voSaKln6mo2zgKXLEqwSg6w96Ylk7GFWfLUMYptpQadExDMJlY9npqdLT2YGQV0y7/bG3pnRlb2Yjfx2tMgg==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1705FAC92101886436DA100F92750@DM5PR12MB1705.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1705;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1705;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39850400004)(346002)(39380400002)(396003)(376002)(199004)(189003)(81156014)(7736002)(81166006)(5660300001)(26005)(65826007)(476003)(31696002)(486006)(305945005)(86362001)(6486002)(44832011)(106356001)(52116002)(76176011)(25786009)(7416002)(36756003)(3846002)(53546011)(31686004)(72206003)(105586002)(186003)(6116002)(386003)(59450400001)(16526019)(77096007)(50466002)(478600001)(97736004)(23676004)(2486003)(36916002)(52146003)(64126003)(6666003)(16576012)(58126008)(229853002)(6636002)(8676002)(8936002)(47776003)(316002)(54906003)(110136005)(65956001)(66066001)(6246003)(446003)(65806001)(2870700001)(53936002)(4326008)(956004)(2906002)(2616005)(11346002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1705;H:[172.27.224.40];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzA1OzIzOjVvTG0vanhERVY5WElXOG0zNHlTQm5idFRr?=
 =?utf-8?B?NnFXVXZSblBocXY5Ti8wMk1GTWlraW1OWEs1Q3Z4N0s1ODI3bWE2NmRqU0RR?=
 =?utf-8?B?cTZHT1pLMmFFbXJ4Y1ZRa3c1SGdFMEx0R1M4ck5GNFlTNmY0YncyMnNrNVh6?=
 =?utf-8?B?b3A3SDVOc0dDanNCWCs2SUVsbnZva2ptd3FvcmQvUUxvY09DREE5S1ZXcGZy?=
 =?utf-8?B?di9wV0JYYThDNWxEUVZ3UlpmRVhzN1B6QzhHTnprN1VNNGpVSXQ5UlRFcDll?=
 =?utf-8?B?eUxkdjFOZTdXQ0IwVGM1dUlMUEU2WnpaUjJXVEVyQldBZ0VIVEJibXNvakVh?=
 =?utf-8?B?K1FGaXRHdUZJZjVSK2R6clhndjRsSjlLWklJT1lmNk5hazhyZEMyTmoyblAw?=
 =?utf-8?B?V0pBS3lmendTOWliM1BJWktnejRiQlZtVUVuc3RUbjlNN0ExRGg0RjZpNVJn?=
 =?utf-8?B?aFpVMmFINDRWSEhIcWF3OS9PNW9tSDZUYXNrdHVacWlpNTRXaVQwYjJYaG1D?=
 =?utf-8?B?SStRU1QyZkFlUU5kWEVpNE1mdkhCS2F2d1grMTVCbGJoMTMrVkIrTnJjT0xn?=
 =?utf-8?B?bkJSV0JNWFY5Nnlhc2lvSUcxZml3bG9tRkF4QzY1ZUN6VFRKejlMbERRWjZo?=
 =?utf-8?B?NDhNMTUyK1dxWmhYVzFld1lsNnI5dERoNm9zb2tRSUlNcFFEdEZ3S1E3NFZH?=
 =?utf-8?B?VDBiSFUvQzg3eGpmdVpRQ3g0U0hBalcwTEY2cllaeDZ5ZmhUZFYxTUFmZHFK?=
 =?utf-8?B?d0twSDRidWZCa1NoRW5zTk1IV1ByVmJ5VTIxdXhDVGlGd21pOXlDMU14VzFQ?=
 =?utf-8?B?NG1ON01tYWlhRThwY283VDFPWTl4OVZLejNieWVQc2JwK1I2MytqREpxSWJ6?=
 =?utf-8?B?U3dkbVA4elVtNWNkdW8wSG9jNzRPRERidU04bFdFZmIzbGZ3Mk5YaFJCMGpP?=
 =?utf-8?B?TXVQZWR6V3ZLK2pRUGJuaGlteEhmZWtXbkZCbE1wNXEzbnlodU5KbkxCMWNJ?=
 =?utf-8?B?bFFnbHRvUTIwbEtpZzJ3a0NBVkN5RTY3Rjc2SGY5bzY4b3dDYXpmdHBIUGNS?=
 =?utf-8?B?K2xiT0VaNVpLMlpuWVJOWWtMcVRuT1hQT25DQ0xWUUx6MjF6Wm1Mc0NGb1Nk?=
 =?utf-8?B?MGxTRGRtRTd2Q1lNcHJMd0cwclpLWlIyRVh0ZDZVZXovMUdEdDdhd0ZPTG4x?=
 =?utf-8?B?V1dzSTdSZFdMM3doS3hIQmZFWlgyQzBQMXVWYVV6NnJVRFRpcUxZMlRKNXBu?=
 =?utf-8?B?YS9jUHF2RU0wYW41YWJIcGZhVEtITlZYTDR5UEkvdEJ6QTUzcGFTMEUxQkFs?=
 =?utf-8?B?UTBHUFd1QlNnODE2dUUzUGJJa2I4a0JDNkZsaFh1VkxRKzd2SG5HVzFkYVJL?=
 =?utf-8?B?L2xhVml6ZlRXZ1JUUGV4YXNWVzNPaGVaUlZXZ0p6dlVZSTBaajlhZFFNcFhl?=
 =?utf-8?B?aVlQb2xVNmZzb204NS9iUkp2TFpEZDNSM3RIdmRGcERKNk0xM3ZZa2MzOWgy?=
 =?utf-8?B?QytwRExleW5INmV1M1NCT0ZzRWRQU09mMWxpMWZvRThvdk9vNGN3M0hYSmFl?=
 =?utf-8?B?MmlkeGJhcjRmMXpMYTV4d2EzSnNhaFgwWmZPcGw3SHRlM1BQM0tEVWpvVUlX?=
 =?utf-8?B?aVJTQm5YcnVIQUVFL3VJZ2tKRDQrRUdhaWFweHZSODR5MlFJWGdyR2xRTmc0?=
 =?utf-8?B?cmI5ZkZwR2Izc2IxamUyU2NvMGhCelhNd25ONmdCemxtS3EzRHQvYk5pOWox?=
 =?utf-8?B?dW5RMHoxMXhLa3E5YU9kckpLVHEyL043YlczcVkrR2pDNFAvU3l0UzJUOUtH?=
 =?utf-8?B?VnYzYjVFSmF3cmpsbTF4bXROSlpEQm1QUDZ0UGNHdFlMWE9ZbzA4YmNuZzRN?=
 =?utf-8?B?c1hUeXQzdUdzSlJvc2FYZGsyWVdnTGNWdm8rVkJGaTNjWGc0Zk0ydlJ3VElP?=
 =?utf-8?B?SGpyNFFHMnFGa0lhZkhyQ3lmbjUvZjRmT2V1ZnJrelRuMHJyYUMwRUNLWmhp?=
 =?utf-8?B?RXJUZk85d1lPUXlsemw5SDVRWXV5ZHhpa0J0cDMzeExYaTNMRU1POTc3SnJB?=
 =?utf-8?B?VWMrdG1qZWM3bXhZNGdETzdwbFRRdmJFWGtUZmRtUG9oaWZPa0hJcERGUVdI?=
 =?utf-8?Q?IyBkXZdk9dV+eMwSqJofPns=3D?=
X-Microsoft-Antispam-Message-Info: 91EjdrO3yrqyGW7NfG1DA3+DLurWaN94Io0c05h4Sx+aNPxU4PKMvqbsRcm7IRwRKyR7ixJFGajKZYDfh2FNPRmsPu/j74r/XZTLqI4eHoBx1j+eQ4Ky84KTWTsfrVuRUB18osq9uOMkb/K9nYNkjSmJoX45/2lv+8MADE+pLshkotZE/MP0EB1nZdIiTts57QYDd11BOfhgOSKiTf9/xvpbi5qGc3PvUrj1Kzc7UuVtCOlTR0ATi8BQgP6kwCIx6awZx3EDcCec+pON9HC12EO0f0id8RlYCDxzXD/94TYTGOP96mVJtT9jOuJs/3dSf+lWpkhIyvJsHyjNZfgvgA==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1705;6:WZbIQ2N1003UBDPzSVjdw5StwRJPYeKOcX4opL8FMNkhvqJ0RGtfVpPtDXfv2wJm+I5dsLs53+dG0tVPLh8tM10b9Qb0mEAsRc9A6WXkWqcpk3TPZeN1Sg5iy8zy7XZpKTmGSlTKDUvO+6mRiveIjlkr90QKdkjjqSvN/BzhwFeuRZPUT+P7PmjBJYbH2IJrq4Bvx0tiqNXQlmV29BQA2NHnsTQ0DGtHD9B5jWEQLGyK8nXQuGuvHEqAYYrl5o/9PyGMzafPZgS841O9Ao6sBQzAlioRQDHa4wYMghTH23r5iWdysmwSzO8y8Jql1TzuU4qyma+7YhVOBzjtxvPUhuvlj0G7KMuPxJfsFz35fkOG+38t6TROgG7FCkKisuWvpVNAvoBUUX0FU7ASJdUN8yABQgXiAt0+6u7YEROprmrvyTOCkiFW6oT+YuAEjvOq0fcb3we1dp2Ji+oFUYRTNg==;5:TD2IRn8myAie3UK/rXzluYYcug7AVE+QUL5m8AA2wivm3ifSY5siBSh47CHibQdFdq7nypXGJWW0txfWga+z9z2/rfdv05BFqRcz6eukKhrv4Spl9lQO9W/W3XVbZitf9P679Ge1e0gjZaD9nFDwEU4syud7PjlwE98+jBzRoe8=;24:LwCDlOD2LQ7sH2g9ff941Eo2nBB45rVKsJ0hEi3CrV7IbY9Y323b4yJ48WDvS8walJc3UsY6lOSnHs/uOUtLRj9Lnn2xljSujrox0/lfZs4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1705;7:14SsiObrq038TdhURGx1gxNVZZilGn4Kd562JV41dFIn4qRfIe8PyRH4fPL97E00VQD7BKuwZc+H1FL4VLEc3QU9aSAr52wIf2VfUgwM+iITHHOybADPF2V3yXolvhh0+yNnOj0YbOakHMaKGowiDmXVFwy/YKTSG6jsmNZ8zAS8lGdAvOuQ4W25vq9ikb1YfE0PnydriT5lRbkjI9vjGJ6m9TSJmu42p7r9+VbNo3iOvIIxoDOasrR5wQ27oWZw;20:x/+BqoccwzAlN/iJOTYddBbqrwMrDgY3vxdA7LIv8hwS7+lJGO2AtklpGpbBPqt42VyMislVAwH9yqkb9of+BbuGFxFAKLzHX4TiZt6kl5sWiQLSkezgJWu+eLWptiL7gTaLCYB5JmhELk0Jbhrctu1EvQaR3syowS0w8XfI+WjXm2qMoSWvGjR2kps/6fYnYS+qNYxKgpMeOAPy1xvrEFve2LGsuwRROvFmPdaIISu+UhqqJtJXnSJWLvyp/0f4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 20:09:12.4611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2fbcb7-5397-486e-de04-08d5d87c072b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-22 11:24 AM, Michal Hocko wrote:
> On Fri 22-06-18 17:13:02, Christian König wrote:
>> Hi Michal,
>>
>> [Adding Felix as well]
>>
>> Well first of all you have a misconception why at least the AMD graphics
>> driver need to be able to sleep in an MMU notifier: We need to sleep because
>> we need to wait for hardware operations to finish and *NOT* because we need
>> to wait for locks.
>>
>> I'm not sure if your flag now means that you generally can't sleep in MMU
>> notifiers any more, but if that's the case at least AMD hardware will break
>> badly. In our case the approach of waiting for a short time for the process
>> to be reaped and then select another victim actually sounds like the right
>> thing to do.
> Well, I do not need to make the notifier code non blocking all the time.
> All I need is to ensure that it won't sleep if the flag says so and
> return -EAGAIN instead.
>
> So here is what I do for amdgpu:

In the case of KFD we also need to take the DQM lock:

amdgpu_mn_invalidate_range_start_hsa -> amdgpu_amdkfd_evict_userptr ->
kgd2kfd_quiesce_mm -> kfd_process_evict_queues -> evict_process_queues_cpsch

So we'd need to pass the blockable parameter all the way through that
call chain.

Regards,
  Felix

>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
>>> index 83e344fbb50a..d138a526feff 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
>>> @@ -136,12 +136,18 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
>>>    *
>>>    * Take the rmn read side lock.
>>>    */
>>> -static void amdgpu_mn_read_lock(struct amdgpu_mn *rmn)
>>> +static int amdgpu_mn_read_lock(struct amdgpu_mn *rmn, bool blockable)
>>>   {
>>> -	mutex_lock(&rmn->read_lock);
>>> +	if (blockable)
>>> +		mutex_lock(&rmn->read_lock);
>>> +	else if (!mutex_trylock(&rmn->read_lock))
>>> +		return -EAGAIN;
>>> +
>>>   	if (atomic_inc_return(&rmn->recursion) == 1)
>>>   		down_read_non_owner(&rmn->lock);
>>>   	mutex_unlock(&rmn->read_lock);
>>> +
>>> +	return 0;
>>>   }
>>>   /**
>>> @@ -197,10 +203,11 @@ static void amdgpu_mn_invalidate_node(struct amdgpu_mn_node *node,
>>>    * We block for all BOs between start and end to be idle and
>>>    * unmap them by move them into system domain again.
>>>    */
>>> -static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>>> +static int amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>>>   						 struct mm_struct *mm,
>>>   						 unsigned long start,
>>> -						 unsigned long end)
>>> +						 unsigned long end,
>>> +						 bool blockable)
>>>   {
>>>   	struct amdgpu_mn *rmn = container_of(mn, struct amdgpu_mn, mn);
>>>   	struct interval_tree_node *it;
>>> @@ -208,7 +215,11 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>>>   	/* notification is exclusive, but interval is inclusive */
>>>   	end -= 1;
>>> -	amdgpu_mn_read_lock(rmn);
>>> +	/* TODO we should be able to split locking for interval tree and
>>> +	 * amdgpu_mn_invalidate_node
>>> +	 */
>>> +	if (amdgpu_mn_read_lock(rmn, blockable))
>>> +		return -EAGAIN;
>>>   	it = interval_tree_iter_first(&rmn->objects, start, end);
>>>   	while (it) {
>>> @@ -219,6 +230,8 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>>>   		amdgpu_mn_invalidate_node(node, start, end);
>>>   	}
>>> +
>>> +	return 0;
>>>   }
>>>   /**
>>> @@ -233,10 +246,11 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>>>    * necessitates evicting all user-mode queues of the process. The BOs
>>>    * are restorted in amdgpu_mn_invalidate_range_end_hsa.
>>>    */
>>> -static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
>>> +static int amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
>>>   						 struct mm_struct *mm,
>>>   						 unsigned long start,
>>> -						 unsigned long end)
>>> +						 unsigned long end,
>>> +						 bool blockable)
>>>   {
>>>   	struct amdgpu_mn *rmn = container_of(mn, struct amdgpu_mn, mn);
>>>   	struct interval_tree_node *it;
>>> @@ -244,7 +258,8 @@ static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
>>>   	/* notification is exclusive, but interval is inclusive */
>>>   	end -= 1;
>>> -	amdgpu_mn_read_lock(rmn);
>>> +	if (amdgpu_mn_read_lock(rmn, blockable))
>>> +		return -EAGAIN;
>>>   	it = interval_tree_iter_first(&rmn->objects, start, end);
>>>   	while (it) {
>>> @@ -262,6 +277,8 @@ static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
>>>   				amdgpu_amdkfd_evict_userptr(mem, mm);
>>>   		}
>>>   	}
>>> +
>>> +	return 0;
>>>   }
>>>   /**

