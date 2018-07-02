Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F683C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF85A22405
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fLa9nDDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF85A22405
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeGBMkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:40:18 -0400
Received: from mail-cys01nam02on0066.outbound.protection.outlook.com ([104.47.37.66]:15584
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752033AbeGBMkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkHzcT+iBlT1HqAwmYhMGqha5WgH/ywivXF098IAPuA=;
 b=fLa9nDDsbQ7OhvnQrnnG9ln9zCpNeA1vNlYRm+uOPIGFN5f81Oa5pUjqEPh8IwV7SWzVrLYJD+v7oOPiavhAyx9+dKwGChVXfHU8h93bVub70jFMYkOC3f59HYyle+G8qOUuhd70TFiy3F4mJw0w2vrRyrzJiNXonBrs9k9YO+E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 CY4PR12MB1718.namprd12.prod.outlook.com (2603:10b6:903:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Mon, 2 Jul
 2018 12:40:02 +0000
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>
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
        David Rientjes <rientjes@google.com>,
        Felix Kuehling <felix.kuehling@amd.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <20180627074421.GF32348@dhcp22.suse.cz>
 <71f4184c-21ea-5af1-eeb6-bf7787614e2d@amd.com>
 <20180702115423.GK19043@dhcp22.suse.cz>
 <725cb1ad-01b0-42b5-56f0-c08c29804cb4@amd.com>
 <20180702122003.GN19043@dhcp22.suse.cz>
 <02d1d52c-f534-f899-a18c-a3169123ac7c@amd.com>
 <20180702123521.GO19043@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <91ad1106-6bd4-7d2c-4d40-7c5be945ba36@amd.com>
Date:   Mon, 2 Jul 2018 14:39:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702123521.GO19043@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR08CA0063.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::34) To CY4PR12MB1718.namprd12.prod.outlook.com
 (2603:10b6:903:121::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae53da0e-f271-4432-e0df-08d5e018f253
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1718;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;3:bU7hFV3lY1oTTmLN4PYkKUk53C8RlutP5RegMvgsAqWgmYA+u3MmBmKpPCgzb4GeYgHQkIXlemvYbnpBvO0F9fXqWgMjsDaijlfipq9ENcNuqEebq5s+CGjVqVzhNe3UVMcDdJ6VO+CHPbzHD75v2IkIrbcWSbw5I4TI/zTckt8wgZvZZdg8jZpe3Dyoe0wDY7oomkdyNhpPe1dCHYpUBFhx5zSo4m8H40lSAHgTrtB6fNXf4z4YkuIuNUaMMKSZ;25:CSDPud/2EtChpalsWmNsSoSP5AGEtR78UCjGtyOi02wmafYGGRibeEHDvXX0Sln7Kmp7sbiVhl1C2BoHDT52Smzmsb4ltKwxZVNEkmjzfsbodR/HTvhAcMl5jh4LSFyqF2Nv3ENyrdXh60ciA1P2DIwQStDXx6YPIWpbY6MW2HzhLo9yIFKLbFTOlTtr3DAEmqjNwAqdLXFPH8q46R7BDzVtezoZ0OmrZCztUJWTlWO3FrmvI5CekyptQ0GLW0Stwb5/fbu1RprDnDCgu68a/UUPQ7XaNTDvF6pw6300fMQsmElWGuG3XEmQe0Dl2zySuPos2skpye1Mv6reWLsW4A==;31:xGuYFEyagiDXvxSWE5PxWH1yB0eZFcZE+/aqmLhHLCPlny8r7azZDSH1mzvGVzM6usq9xPwWjJoxUT9AJxn0nKLPipuV6x8O9sIvsqpWWiU4ZtxtEKkPc5/DZNObAw4Ty2eA3bElfFme8Fo60I9N5jhVKvMwD3thIKrlnRe5NDIKZCQM0FcgkQju+chckwRW0Z+8rZTrtDvpgRStPpPaLjhf+JNWv/V60OrhEBnoANw=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1718:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;20:mGxXaXIFcd0rni3kzpWPcA0I2v18hXJEkks5W9ZZ3SgTjzEpSdmtCLj6+c2MtqgwMIdhzbg2/irkQVmSnDYnhNO3Rx1h9A+xrBsQ6AY0ihRRKtIm+8zBTpxFFstvRRocMJevNcmHa9SvjzUjpChNJxdbHy/MsSpdJLxFoVaUnvj2X37xIc1pxbceQwEFEUltTE6N+Egtpbw/LkAO+OeC0h/V0KuHQxnjonyjUnPDbwK6sCJJ/tusQTq/9o8jqKe9wVMV3ifZ4xVdtLizoF8hbX15u8emPrM5Urvlf+N1lsasdwaF6fMD1chseCYijV8lq/XxPRxYxop4aTeEPRSKoj6os8BV9kDRV2QuKqDrnzZwFts8EdqYK53gWLKVGrwTDgv2TNz7Tf8R3QU8et/KilpcxCISWXcO1Ot7+4QBgnBr1OS/Fo6CkryMI9I4rq/Aw0tk+XCnWT5ovOf7XGcXVIjyLmnofgiXARg61cAPYLUYFbHpAlHg+4YT2JVr3ODx;4:ZaiLpHLDha4KzTOLrLL3TktCObFyq9KVX/uGWsWsBvdo7tk5IE5ea8uznjLoohuBFnFjt9x4wDabhf39AsEIjxkh1ky45cNHShY4r2YubZIdk09oPcoO4S6HEkyooS8vabBQ/LjZc9+sod9uIwhdRCTLwicZx+f6N0yCmUMEh/XRH2bGx0qtVfTisPFKlHtm/0OvPeG+kf5SJj/d7ONVcWAsF4GIksVp9WwsDeSkOUvk5BGIudaz3XijHowrc3yl4GhGQho2g8gc3nFz5Pdz4Bk7r59ejDStmXgR6IgnYqVY3UxwV+DxuXDAHMMavxNRPh2RUAZU1NjtBylMgI9fhQ==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1718EE42DE7CC8D5D3C60F8183430@CY4PR12MB1718.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1718;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1718;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(386003)(16526019)(6916009)(6666003)(11346002)(446003)(2486003)(52146003)(23676004)(52396003)(76176011)(46003)(52116002)(8676002)(7736002)(305945005)(105586002)(5660300001)(106356001)(65826007)(50466002)(7416002)(486006)(476003)(2616005)(2870700001)(1706002)(6116002)(2906002)(36756003)(97736004)(47776003)(65956001)(65806001)(316002)(54906003)(58126008)(72206003)(478600001)(53936002)(6486002)(6246003)(4326008)(81156014)(31686004)(8936002)(81166006)(68736007)(25786009)(86362001)(67846002)(93886005)(31696002)(14444005)(64126003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1718;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzE4OzIzOlZTazNzZW1Da0hvZW5BVzdheXVRdTBmYjFJ?=
 =?utf-8?B?THE4bXBJMEhRZVZYNFlmUmRJM2ZYVy9PakYvK2Y2STZ5Q3o5RjQ5MWVZMWh3?=
 =?utf-8?B?YmsxdnY1bzNCS29xOGVNRFJEcDhMempoZ1hlOUpyR25pWG9XR2lqZXFnRE9R?=
 =?utf-8?B?a2R1TG5ENElhVXVaNFMzL3lSZFZ2Wnh6b3JySWRkZSs5R08zekc4WkRmSHpL?=
 =?utf-8?B?SjBEMk9ka2svM2ppczdTaDZoMEhyNDhwMnNwMmdJdU8yY0pEckpmRUZGYjhC?=
 =?utf-8?B?b1ZFWUwwTnJBTlo0YTNSeU1mblREdWRTWkFVWlhFTElHQ0VYUGNueUJKU1ds?=
 =?utf-8?B?TklkSVJ4VjVtWXJ4c1RYS2JMUU1WaWwvcTl6OFYweFBOVGUzcldsWHczT3Rh?=
 =?utf-8?B?aUhKSU1PWkxvdFZHcE1HaU0zeSt2WDlpWnQ1SXYrL1JhL2I0d21sb0VDS1Zo?=
 =?utf-8?B?ejAxdzZZNXdXUk1uT2JJQVpWQzVZTGJ1MzRFclNTSzhoWEQ5enYzbHh3RDBp?=
 =?utf-8?B?cmU0VysrTkM1eWpOMU51UWp6MTNyWEhnTStWQW9nUXJ6T3UzVllUS3NyWlVI?=
 =?utf-8?B?cXhxdEZialRhV2dZTnphTmJrQVdsWDZ0Ukt0aUNBaDdReDQwMzBnWXhZa2xs?=
 =?utf-8?B?Skd1OG5WSkxGRzhpeUw0bHNXUzVhOXY2dUNERmdFdE92YjVYZ0hVeTF6QWZC?=
 =?utf-8?B?S3p6WG5GbXJiNzRlS0h1Vm4xdEVhZ29zSjJRTWIyMUlYV2I4dWxNQ0ZQOGw4?=
 =?utf-8?B?VEVzMUtqaEdlK1BiUnBjcEpRRTlQQjdya1E1UVdRaWxqb3B2bjRZZ3NaZ2tw?=
 =?utf-8?B?dUtiVGRjVTNaR1RKbFgwT05ZMGVqUlRlMTBkeHE4aVE3NWlPbkJ3NndTTDZw?=
 =?utf-8?B?UjZ1aFdDVHg4L214Ylp1SlJWcXV1ZmkvTDJ0MUZUaTRwSWVxTGxhbDZrZmJJ?=
 =?utf-8?B?cUtoKzdXQlBLVHRPeS8zTytxZERjNTI2VWhlNTJoRkFqcEtqa1F2V1VYYksz?=
 =?utf-8?B?bG1ETldFd0ZZWXF4dXZ6UC90Nzl4VnJNMWZHbXZ0anpBeHFTS0FFT3NMclFY?=
 =?utf-8?B?dEl0T01ES053cGpxUCsrT3NjdGVheDBtdCswWDgxakYxaEQ0VkFUcnNLU3Fh?=
 =?utf-8?B?NXBwd0xkTUU0RW9pZkV0cmZTV0E3eGtrY0NLUFhVTm9JbTNHMXJpVC93WVY0?=
 =?utf-8?B?S3RMd01RZ21IMnBUWmM1cmNLay82czh1SzBYYTMxeVZQOGZJeHJJQ2pqa1Ns?=
 =?utf-8?B?ZjM1L3RqYlJaWUx1K01aTHF5bEEyd3p6QmxFUXNPeitQTlNYLzZSeG9qWFJV?=
 =?utf-8?B?UUVhbEFSZUIrNEc5N1hybkYrenRwMkR4aXFGQTIzdkZzdncrbUZQOUkyMU01?=
 =?utf-8?B?bzhVOUt6TVYvR2FrSzkwNnRTdXpXOWhhS04vaWNIeHh2eGFsL3J5MXN4VUo1?=
 =?utf-8?B?RkE3dFdpdDZjQUpIMDRBc2N0VE9wUzJCb2ZGT0U1ZWdwSTFGRlM2eVpiRmxD?=
 =?utf-8?B?QVoremZoT05ScWJscEp1YnppbjJCczZ3ZGhwTWZWSFltanpYMTR6YVF0WVlm?=
 =?utf-8?B?dVV0Zk5RUVhFcmpxVldOQmRXTEdjYnNZSEQ2WXhnNFNSZE5TYWhpTm5wVEdy?=
 =?utf-8?B?U2tkcHFJbHpPVitpK3NkYTdhdERiU1JmQldyc1JDb2pCQTRRNEk4aW1kMHRr?=
 =?utf-8?B?OEhqQk0yZzVwMnVyeG1oQ3RSRVZiMGZBWFlHNVBPVjh0WXRCSzA1WmtpRVZx?=
 =?utf-8?B?eXJIdTcrR2NHMW5mckpMdmtmbUVWZzZTVEhxZzRHRVpPZEo5bXpBQ3Y3N3My?=
 =?utf-8?B?dUZWVXdlUVMraTY0MG1qTlhFaGx0UWJrWlRSaDhTZ0YrTmsvaXowV1BEamQv?=
 =?utf-8?B?cEtQK2FXcXZuNHZ6b0JDY3VLdmljZndrN0F6aDJPbjZZMEd2NFIzOE94R3ov?=
 =?utf-8?B?Z1VQN3FxVTBnPT0=?=
X-Microsoft-Antispam-Message-Info: 4rK4n9ZKXsNKbm37/Yl3mH3qhXuMh8D+6yA425upQwjs3pUH4P9kQsJNP3XkqhnjGUq7cMkkpp9RAskPEEbCYnt+mFU2A7EcEm99P02DLj1aYbuLkPb/azq7MyLuIDNJtVmQ4NjMoXkaR4kz7/8Ga9CyK9QXg/RFLDg3Aw5YjhbP+UFm3kgfurYfkpDYBxxFHmrEA9KbnfXeVUlpLliBSzJqsDtzJf0Ox5iw3Frh/+4WgzlJLQL4/nMlx//IdVm90s4CvsnAEEgtGLc6SeGBgiFklfkxlKt4RnDLPv5D7xmeyFIgEnLjbLQUHs4sxHLrwaqQMkt4OTKkuwjDceAVUFYhSzAV8DAZI9VtAjh7U+A=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;6:gRkwW/oX0FJpkCGDkniM/fByMK7e2xM+hvaGqmO2DWl/TjkZzefYk2sMddl7X65XEqWcwdF9VUkpbW1/P62HbsBziyhWCLBzRZ7x2bjshO4cixEy/nyK2I/9TPi8sVnCMNaica/XQBHvNQTOjDqWBFGHNi+/Z09PlO6+2qhSdvPKuCsYYYeDqtYpKsaL/oxpnZCFXRI71SCeMLQQb9dz063dGwh8yFXT62v/Z4RqaXCvr5MZ6/mSDYK4C6LdwIpe3SwfEIRnLa5VYZ/61N0KaPfTOx+NdvOnQ3qB7vyMW6yE4/wDLvsnO6HJD6bWuhsJRzjqFNh3nq0w12U01BH3BGAF3bmJMnJf56GespsOGd+i7FZSjb9MhWXo9nG8xH7E2PB9M3dMncxGKP8HaGF4JnFF40m75zdTAnkiMjTFPTdJSUUYGjOT2jRGh/rz1BCg4fHTmfB4pgRWSKhJjjQjRA==;5:ET85fkcYWRufLwEAnoyec4GA/NmLUdFpMnYyqoRE1Sm9/d3b4ti4ZALl9JXTmaQHyU0nYvOz0GKTRBUdEZvEiANNtXH7c5Ew1l/MnLpbjzJ2E+aBBOY4D0Auu9a87Tlq7yuzpw58ChXg7AM45+gSTszCQP/cupIUXHvk687Mcvc=;24:a+VuCdA2jd0LItSSLa+vb1QoYjrnTHzb3hs3D1stloyBJa/nOimtD6tLDuH/Rgh+vtvfoPpIztXRY0C+PVOUg+KThOYF4xl/itcilGPQ1pQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;7:nq6Ss4xXsC0XRCQiDFMRt9FY+6RVO6ve3JMK1tDq9Dltf7ezaU8dHxPWJLCQp9dxqwNITVqWViyhyWMWOJsJek4kho31kI7NHOKL8zd5fVTvXVRyes83FCHcNsVFqi9PU7CJVln0rU1//SQZ0LT6o8/sNxoFgMHfSgOZqmv6Lt+OjcHTzcH5XcfPFKVl7iCTcA5JCoroiXobMyfGAlVXdJldveLjiCXMUdaHUZDwHT3MRyvOE3+Y/RDpJK6+/09n;20:v0Rs7ugYSyJs0EdyWQKWFyb/iM7mRR/dqIpOf6tDROMKjefVuD1Mtrkzl8fFcir7HbeECMiPE1RO+5QKoBwyIhDue7INATv6eVnXF7zQbjCkZ3XE4mDQBDI2Mss9HPSAdSSVKIIMtu9vJCjCNhDY2FlqRpX+sOC/VOlLfzdgCZSKG1t+3RqCpex9nLd5gk+FCOEWxnFzL3bDS4J5Igg/t/1olvFeP/yjc9pOtSkCSqWnN2odj3UWMDF9YOwetKJK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 12:40:02.5962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae53da0e-f271-4432-e0df-08d5e018f253
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.07.2018 um 14:35 schrieb Michal Hocko:
> On Mon 02-07-18 14:24:29, Christian König wrote:
>> Am 02.07.2018 um 14:20 schrieb Michal Hocko:
>>> On Mon 02-07-18 14:13:42, Christian König wrote:
>>>> Am 02.07.2018 um 13:54 schrieb Michal Hocko:
>>>>> On Mon 02-07-18 11:14:58, Christian König wrote:
>>>>>> Am 27.06.2018 um 09:44 schrieb Michal Hocko:
>>>>>>> This is the v2 of RFC based on the feedback I've received so far. The
>>>>>>> code even compiles as a bonus ;) I haven't runtime tested it yet, mostly
>>>>>>> because I have no idea how.
>>>>>>>
>>>>>>> Any further feedback is highly appreciated of course.
>>>>>> That sounds like it should work and at least the amdgpu changes now look
>>>>>> good to me on first glance.
>>>>>>
>>>>>> Can you split that up further in the usual way? E.g. adding the blockable
>>>>>> flag in one patch and fixing all implementations of the MMU notifier in
>>>>>> follow up patches.
>>>>> But such a code would be broken, no? Ignoring the blockable state will
>>>>> simply lead to lockups until the fixup parts get applied.
>>>> Well to still be bisect-able you only need to get the interface change in
>>>> first with fixing the function signature of the implementations.
>>> That would only work if those functions return -AGAIN unconditionally.
>>> Otherwise they would pretend to not block while that would be obviously
>>> incorrect. This doesn't sound correct to me.
>>>
>>>> Then add all the new code to the implementations and last start to actually
>>>> use the new interface.
>>>>
>>>> That is a pattern we use regularly and I think it's good practice to do
>>>> this.
>>> But we do rely on the proper blockable handling.
>> Yeah, but you could add the handling only after you have all the
>> implementations in place. Don't you?
> Yeah, but then I would be adding a code with no user. And I really
> prefer to no do so because then the code is harder to argue about.
>
>>>>> Is the split up really worth it? I was thinking about that but had hard
>>>>> times to end up with something that would be bisectable. Well, except
>>>>> for returning -EBUSY until all notifiers are implemented. Which I found
>>>>> confusing.
>>>> It at least makes reviewing changes much easier, cause as driver maintainer
>>>> I can concentrate on the stuff only related to me.
>>>>
>>>> Additional to that when you cause some unrelated side effect in a driver we
>>>> can much easier pinpoint the actual change later on when the patch is
>>>> smaller.
>>>>
>>>>>> This way I'm pretty sure Felix and I can give an rb on the amdgpu/amdkfd
>>>>>> changes.
>>>>> If you are worried to give r-b only for those then this can be done even
>>>>> for larger patches. Just make your Reviewd-by more specific
>>>>> R-b: name # For BLA BLA
>>>> Yeah, possible alternative but more work for me when I review it :)
>>> I definitely do not want to add more work to reviewers and I completely
>>> see how massive "flag days" like these are not popular but I really
>>> didn't find a reasonable way around that would be both correct and
>>> wouldn't add much more churn on the way. So if you really insist then I
>>> would really appreciate a hint on the way to achive the same without any
>>> above downsides.
>> Well, I don't insist on this. It's just from my point of view that this
>> patch doesn't needs to be one patch, but could be split up.
> Well, if there are more people with the same concern I can try to do
> that. But if your only concern is to focus on your particular part then
> I guess it would be easier both for you and me to simply apply the patch
> and use git show $files_for_your_subystem on your end. I have put the
> patch to attempts/oom-vs-mmu-notifiers branch to my tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git

Not wanting to block something as important as this, so feel free to add 
an Acked-by: Christian König <christian.koenig@amd.com> to the patch.

Let's rather face the next topic: Any idea how to runtime test this?

I mean I can rather easily provide a test which crashes an AMD GPU, 
which in turn then would mean that the MMU notifier would block forever 
without this patch.

But do you know a way to let the OOM killer kill a specific process?

Regards,
Christian.
