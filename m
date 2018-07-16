Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E133BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E02208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kpNz8iED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E02208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGPTo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:44:28 -0400
Received: from mail-eopbgr680055.outbound.protection.outlook.com ([40.107.68.55]:14896
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728116AbeGPTo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIsHWsVfyKfS1h1WYkas77nR9teBDhgqOvxTe8PTOS4=;
 b=kpNz8iED3yVK1QVRHW1zJyGLLui90BV6Hpqnm+CL0L6rSz/I2beoojcfrE2jNg+sdmlr/u7Jqofm2p4IaU1jfFTFRAH7zhhLj2gbwwJzgGVFOX+HmknSG6BDHx/d3tvYiC8NElRJl+AsFLS6Gw6FYQ4aCIscTh3O9vJY7rb2fQ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Mon, 16 Jul 2018 19:15:35 +0000
Cc:     brijesh.singh@amd.com, the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        KVM devel mailing list <kvm@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "# 4 . 15 . x" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/efi: Access EFI MMIO data as unencrypted when SEV is
 active
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
 <CAKv+Gu_3kD+7O4oR9751VH2CsG=+NmBY-Gypc25LFo9eT6m3RQ@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3b48a62e-8a5c-3e83-2935-03c9ab011403@amd.com>
Date:   Mon, 16 Jul 2018 14:15:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_3kD+7O4oR9751VH2CsG=+NmBY-Gypc25LFo9eT6m3RQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0801CA0015.namprd08.prod.outlook.com
 (2603:10b6:803:29::25) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd06adcb-e395-4317-44d1-08d5eb5082be
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;3:ah2xSKIGeeljGXk4oW/vY/HB3GUvWGyXTx9ZvgzIkUphmwPuIqTwYUlL9ezGSc6vW/AsO09JTYhp+an6jSx0JbeldM2oq2mfQktgAj6UH/h0DstsT7qXMgS1B+IYtcsDxN891CD8wTKTsRLCICLUwMU8QBkrftbkX4hNXUjGUG3pSgrs1/T6+7rFMU/k7mURw0ZEnmKh5KssL0iuLGmqj6jhTioNzCRro5KQVqazygQ2B5pmTAVU19ajXZYd8e0K;25:omGULHr914X5BSQA0F0ajJ5Y1YV2KUJ4gsjwAOaEc6fZydgBCD7Ziux3IfuspugcDHMINrMfgqE8tvNH6JEjjvQ7KY512XwgggHmAa+gk+5gkjka70GTFfPCidgSD4GLRnOzDHLbTr4W4BLYDOnQVwuqnVVHQz2GnYtfZlAARZ3VGptD9rtBrGI4zMzBwLDPpCsS3770NOCrLM39njntEnNJz3etRpidwj8z/Su10mVx9uoEbgpJL8zkNgdaMdcT2EF4l5h4P32p6CXNZlNMiPXYN9sHgSEBd5WO435l2pTOemKITIJfKm5DK46Z9fIq2/DaDd40k+5od/cKihsULQ==;31:UQBAGTzzy8G4ak2mX5diIg0y+jAapMBKE7Y+F2QAZzlnyu3SZTeayITkgN9xMfqxRj18lmk9GRWh59XDVct5++17YCsEGtwYuohBzeV+FccieHo6Ql/9ba16MSLgqzdPNZlppNnJbh/t4IfsCE2vvGiZkXG3YLndNe4o3ePL+4O41XqkIGE+2lJ3gMOTqlGSkDE3setYNQhyBT6Qf8JbiGSNl3cYYhzHgMBfNM0rJm4=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:e9nTPk42upw6ovj5tGAmTkSQUGXk3Wd311YvZcf+yz7BrK8NlLXa6k9qjh0YF4ZSSjVincFtw3MJTCcDRli8abBxxvuNcL0RiHHKOnH/8CjfBzP+Z6Pp49jgg3TiuebeM4W2ikXPHvBSKSEmBeRWIWB8t0UIJYn7tUtjEU914UxcNe1O9/PNQwf274EQ8hNX0hl7L539kBP+NiE1b4w/kSEVTub2j7Nsvylr+hc59/nfPWZ1OAr4XDnhVgmYdg92K+1lZJayQcFOyvWNbZFjxyKLlb9D2Ifw/8i51ozmkWcYdxDpxTtRflsV2rT09O3tOVpCELeH/NpAh7kjVBB79RIOlZI3ZF85+mYlU3fUT5UR1QUvpcki4lGYo4HGLQYH9bBz6GE2GUUY7cNIlJ86LYvUaWy2+6Gj4BMN4zU320c7V9DsA/5BNo2WOnV2/4E6jOgcKQs9DwYdpfUZtIIIEDYsEjPYC/4qc4v9dylPq9/byfWcO3iVfnRwg2fI3HfP;4:HKOmHW5BmSLwFGH3uBxTRaRpEuwopiTsNEWxG+FhikU9kev21VSQ1BlPRjvB45jv0khiozjPBK17MbDS4n864Ma7Ni6eWXmIIEhxQ1Fax2ozF9CBbNpdNX23ZXmm8QVbKoCzXvFr9aV7tuxSo/LCnuMFTLPa9+lHRnax1f9JwEsUuet+h9css9f4a+QsSDJBVFgDOoNmOjpLzsLA60Cw4GHp7HBiOHFzWRhZQ2K58G2MRc7RgOFUHcMawAQKcxuxzTHTRmEh6fhFoNgVs5ZxJWgF9ZtrgBC+tzkBgxk7VjGRcDo1zW74IkSt89ElyrumtSFGY1fWU69yFIwMv0FLAw==
X-Microsoft-Antispam-PRVS: <DM6PR12MB26829C523D1F4CE6345B5C1BE55D0@DM6PR12MB2682.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR12MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2682;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5660300001)(446003)(66066001)(50466002)(31696002)(3846002)(6116002)(68736007)(44832011)(58126008)(65806001)(97736004)(54906003)(65826007)(14444005)(31686004)(105586002)(230700001)(65956001)(6486002)(217873002)(86362001)(106356001)(36756003)(316002)(16576012)(81156014)(64126003)(478600001)(4326008)(486006)(52146003)(23676004)(2486003)(2616005)(476003)(7416002)(11346002)(47776003)(8676002)(305945005)(53936002)(76176011)(2906002)(25786009)(186003)(16526019)(386003)(81166006)(77096007)(6666003)(6246003)(67846002)(53546011)(7736002)(26005)(6916009)(956004)(8936002)(52116002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2682;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgyOzIzOlJ0UDBkWlpzdDA3TDNzTkFhN28zdytVempq?=
 =?utf-8?B?OFVUdEdaSG92dFYycG8xdkhXWGw4YVhjTXYvcHdvVmthWGRScm4wcGNTL3hy?=
 =?utf-8?B?c2pvZy9BUFkxa0RDNHEyYlAwUFAwL0dxVzkzaWFic2xiYVRDSEtDTkVKbkV1?=
 =?utf-8?B?VlZMdCt0VnhJMVFybHZqRTIwd1M0UzN5K3pDL2dlek5tdlJPaUd4Nis3ZUM0?=
 =?utf-8?B?Uk16NUR4eEVRaWJrdGU0cis5NUQ2MGFvK1lFRXN1Qm93RmZPY2IvWWEwZzk1?=
 =?utf-8?B?L1VrQVg3b0tuZVZpcWxiVXJXckdvTHVKU2Z6aEhtV2tKYS9oUGl5ZFhYRy8r?=
 =?utf-8?B?Qkh5Y09rb1lpMCtudWtwdU8yMStRQytSaG1MM2dEK09DRkF2aUVGN1dydENi?=
 =?utf-8?B?Ykg2SGFnaSt3VEozZ1BDN1hyNWVIbzF2cXF5ZDBmTlc5b3gvL1hLQTFVWHhp?=
 =?utf-8?B?Z1prT1ZrZWdVclBlbFoydUk0WXlkU3RUZ0lrMnhYbTVnMDI5WHpBbEI4U05z?=
 =?utf-8?B?eTcwMC94eUQyb2Vuay9sWmJodW1nYTArOWYyck5lamZlSzFPYTBJMFNXdzhR?=
 =?utf-8?B?U2pJRUc2WDVra1R5N3VnUXRRUkVHNjlONEJjL0F4ZktIVWYyenlHUDZLWWMw?=
 =?utf-8?B?T3g1eUowaFVBcWVlYUtKcGlLUG9Ja2lEeVg5K2NnWjdxQzltV2F6WWtQWFha?=
 =?utf-8?B?UXpVVHBSUnhCRWJuVGh5bnhTeU1KTFBRMGd0aHk3TkpLMnl6Z2Q5RTBZZ1V5?=
 =?utf-8?B?OU1WRHpKdEFxTzlrMkE5WlRqWHFQSWFwb1BpcFdQOFAyc1B5RlVhREVFd1ZK?=
 =?utf-8?B?ZC9aQ0lDT1ZzSTJidUR4amNsU2t6UWQxc3ZNRmUvY0JtSGZEaG4vbko2VktC?=
 =?utf-8?B?bkdoUE0xR0RVS0ZUUjRPN1lUT0NybTVKaGM4eGx3b0N5YkdRWnJOVHMwRjB6?=
 =?utf-8?B?dHZTZERDUFBOd0VSMGNnaGpLVTVhVTFEVWdjM0lYYzhlZWg5TVZoaHp3OUNt?=
 =?utf-8?B?SCtQWFB2RjFQdERwcTJPMmtvNEkvNWxWWjkwSlJ1VnJTOVo1R3pIWmpmVFlh?=
 =?utf-8?B?SXVVTjdsTHBudVFoT256VEJRMmJUTDVGeVllcHBHUXRoa05FL2tjaEgvVVJO?=
 =?utf-8?B?Vkd1ZXdxcDYxeFloaWtIelVYTVVFTkRkYjc4ZnZJSFNSbWxsNlc3bXZ6V1VX?=
 =?utf-8?B?Rm1iM0xBVXh6cXpnWjlQWGJudDVNSmxISEZLakJ4N2F4K1pGNHJyREphU2h4?=
 =?utf-8?B?TDRYOVY4L0NXT053bGRvTDA3UFRBbEhEZ2ZFdVNZWWc2QUNGUlJCZXRjMW0y?=
 =?utf-8?B?cWo5TitQY0QrcGJZNVgybi9uMDNNL2xETExSa2IyU1VJcVl2RW5VblZneXc4?=
 =?utf-8?B?cW8vWitLYitCQS9mR2E3ODV1TkFORXdiRUhkbDR5MEhxeG9mc2U1VVBPZkRL?=
 =?utf-8?B?NlB4SDlZakdBNnlFN2RRQUdvL3dJQ1RWSHNsRys0Z0hwb0xZUVprSThZNjd5?=
 =?utf-8?B?ZmJZUXlTLzBvdFhrZklveFk0R0VOMlBRU1E3VU1OcW91Wnd1N28ycENWa2dU?=
 =?utf-8?B?Sy84QktzdzRaM3RIRnBQYWorT0FycmUwbllRTmJTTnFqZUFCbEZQQ2NSNHRC?=
 =?utf-8?B?OVplaG0xaWdabWI3QnoxV2FWbWFNSVpmZGxmVldQWWNvUEQ4alByUkorRWkr?=
 =?utf-8?B?S0twOFphQkg5eHRnV1BBWVBYMnljTVNDK2ZvY2hmbFo0SUtJd1NheXl2ZmNK?=
 =?utf-8?B?WGs0d2MrdE41SFhHa2FBZjRqYlZuY0VzVEtmMCtXQ3l1dlhBTy9aUXlaOHcw?=
 =?utf-8?B?VVo0WFJxYytrUHlneDY1R0ZNaTQrYnRZUlpkNCt0Vk9haWtSY1RyZk9GMzdr?=
 =?utf-8?B?a0pvNUdRZnV3T01tMGhBV2pPRXdGTWxwbU1TR2JnVk93eWNEN0RRbXVyR1Vw?=
 =?utf-8?B?TmFLeTQrUTVqcXRhYlQ5bjdBN3RvL1FPK3BrNTlhMzlhMFREUXZUcHUxeWJm?=
 =?utf-8?B?V0FZZ3hja0tnczZTL0NySHpvbDJpMlVJZG5MS0JkbUlPUDltWHZkMjcwSXYv?=
 =?utf-8?Q?sq5Du71LmKZKCl29ghDIF9Jsi?=
X-Microsoft-Antispam-Message-Info: Gi/M8dWOENMy39X4aJk8E+sJrdt5fasQM68H1ec6Wa5e0WdjS6XXCfoTAQTttoysrU01o5wC36wwNF0cs6ScQ9T4xPN6B7UCzyNYjkNxdy8ZJHr6utBz/MpJEZYW0I2EzdptL6g/uuSokXDN7F73pAHInWs2Dk4adBql7M0Ly71Q5DQ3uUzLMx1Fdjes8l+HUh1N+aub1zdWLvW819xyGN8uaAq8PcpBlmC85klLWxC4H6qEOTpoSkQYGety1t73OAmdmBFKPcFQ2ZaVfL54NNJf15Eecf5MXy60NvTPJTD3G/0w9qzuFPJw0crofw3oGS7GNzJvzoW/xT4B/zpcNsedl2OHJDX+PcoCl3E32tw=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;6:jqAgkP2rvp5+rofc9EJoM/JoqWv62Ws/967dCgLVihIplWGtpOAttvhRNalU6KjiNbEGyKjrZLbSBXwBc7oucOvn7ujCfCDNnc9oKSpkC7zV1lsCiYaPGSgRthUPTRSkEm8KbjZXXdKh0DmrAURD4Rq6ntKRLxip+EOTc8GNfiNnTfDMIVeW8uXslWlkHSrPa79LIZVNMvaOJszYI9Zm5NJwlYjbN7CwOPt/j92TKZDY6F8/rubJDgKic2xcp1eR3vWpQdtyGKvMU96pgPjXv9M3s5ep0M0ljI1oUI+L7xhkm+OZHV6CkEaccM3vZbcVRBEOGxVXzOFcE8qvGHQ/DjuirqSR1r109FOF5PlJRKQ5e8Q/rBFQK+mD0MlY+SB1IkYbk2vYijISvhzAzSjsDXZL7rkTwHYDYnlNorwaL53hdFv8TquMU/sR6ViBOAWx5oryo3KpWiZNSyhOlziifQ==;5:va2fUnVQ825PeeA+p5fW8v45QyijXqDyJZcdcXOkQQzQ2d/2NJEfsKAuufbKvTsx136quC/mJGdGeul1hPecYXiiGm86xl8SIpFvpbbHTtDyvTVdUvK0ng3DjSDk+pTNK64xuHtzduINkx/HKZmbrn4/5tP3lWzqJfpazWXeEgs=;24:4MMlSdzsj2Hco1LRuPt18I/j0JNiuOR58gXZIo5ttTg1uk99E680jDatM4V+5NiKSPWlL4EUG2qIeYSG3+9QksDbEDHfHEk6SjKqCqin6ns=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;7:cmjag84/Cy5k0AwV9D7cQm/60dW/uhDFDPE7d7taXlSyOj+ZL0SOLJA4DjI7qq/UQhur6TRhOOKWPA7lIfXRU617ZQpyQeuIM7c3kxvEjCjER4+EGvQ9YUQYr4NOki8FvFcM7JmPQRSE1uvrUDt3JDBiAQCsGqKchlaAuB8GZ2v/CaTOwrxUgrmyUSE4sgVfhGBBQA2SNmlnHwEmniTNCQLY2zj76jsdTfHCn4GV92NmL91TBUVxZejE7Vi5SQ1M;20:N8bZv1VVxggLE3+prPxOLf6avWXXFrQz8wh5NpM/XE/phu84JZTewicrNVDLHE6wNlXiYh/BuZADgNgRyrxjRaYbMpDA+f0eBCtNYPaO3/BEqNBOgUx4+PX4LVJpAEQjmSCl7sLCEnRm5u87VFg7GZMl52SV9jYjS3SmkawJnY+jYmucOCy2tOB/QUrp4DWnmO74LIeALD0RbTQ/zGnQT3H+AtA2kQzxXult5ceRfSm1sXpo7RUycpadfsoC+q4L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 19:15:35.7149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd06adcb-e395-4317-44d1-08d5eb5082be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,


On 07/11/2018 05:00 AM, Ard Biesheuvel wrote:
> On 3 July 2018 at 15:32, Brijesh Singh <brijesh.singh@amd.com> wrote:
>> SEV guest fails to update the UEFI runtime variables stored in the
>> flash. commit 1379edd59673 ("x86/efi: Access EFI data as encrypted
>> when SEV is active") unconditionally maps all the UEFI runtime data
>> as 'encrypted' (C=1). When SEV is active the UEFI runtime data marked
>> as EFI_MEMORY_MAPPED_IO should be mapped as 'unencrypted' so that both
>> guest and hypervisor can access the data.
>>
>> Fixes: 1379edd59673 (x86/efi: Access EFI data as encrypted ...)
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: linux-efi@vger.kernel.org
>> Cc: kvm@vger.kernel.org
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Matt Fleming <matt@codeblueprint.co.uk>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: <stable@vger.kernel.org> # 4.15.x
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/platform/efi/efi_64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
>> index 77873ce..5f2eb32 100644
>> --- a/arch/x86/platform/efi/efi_64.c
>> +++ b/arch/x86/platform/efi/efi_64.c
>> @@ -417,7 +417,7 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
>>          if (!(md->attribute & EFI_MEMORY_WB))
>>                  flags |= _PAGE_PCD;
>>
>> -       if (sev_active())
>> +       if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
>>                  flags |= _PAGE_ENC;
>>
>>          pfn = md->phys_addr >> PAGE_SHIFT;
> 
> Is it safe to only update this occurrence and not the one in
> efi_runtime_update_mappings() ?
> 


It's safe to update this occurrence only. The SEV support is added
in recent EDK2 bios, and the version of bios provides the
EFI_MEMORY_ATTRIBUTE_TABLE. Hence the efi_enabled(EFI_MEM_ATTR) check in 
efi_runtime_update_mappings() will always be true. When EFI_MEM_ATTR is
set the code updates the mapping and returns (see below)

void __init efi_runtime_update_mappings(void)
{
    .....
    .....

    /*
     * Use the EFI Memory Attribute Table for mapping permissions if it
     * exists, since it is intended to supersede EFI_PROPERTIES_TABLE.
     */
     if (efi_enabled(EFI_MEM_ATTR)) {
	efi_memattr_apply_permissions(NULL, efi_update_mem_attr);
	return;
     }


    ...

}

The EFI_MEMORY_ATTRIBUTE_TABLE table does not include MMIO regions, the
table describes the memory protections to EFI runtime code and data
regions only. Both EFI runtime code and data should be mapped as
encrypted. Hence I skipped updating the efi_runtime_update_mappings().


thanks
