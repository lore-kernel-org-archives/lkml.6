Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E78C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6057C20867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ysvEiiFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6057C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeH2SiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:38:15 -0400
Received: from mail-eopbgr690055.outbound.protection.outlook.com ([40.107.69.55]:2981
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727537AbeH2SiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb7mmXjzSSSkQzlAypvhD4VtM+YPZ0aMwGCbtiz/AXA=;
 b=ysvEiiFKzO8R8ssXK+81DB4Bj1HHDDA1M4P5cL2yh2BfUrP8gwc7J2AgltOfagEZY7qy1ge0B8O45uuIpt4dTsR4uy7nDc01LB5fvF7mYyfD1XNvkigqke3miwt9nTDwLzf7dHPSn3FIT3GbhzmaMb/r46HleyKSEvl5NjNG6dw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BN7PR12MB2674.namprd12.prod.outlook.com (2603:10b6:408:29::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 14:37:50 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 2/3] x86/mm: add .data..decrypted section to hold
 shared variables
To:     Borislav Petkov <bp@suse.de>
References: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
 <1535494377-25600-3-git-send-email-brijesh.singh@amd.com>
 <20180829135949.GF6337@nazgul.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <16738629-2574-69b6-1ce6-0d37fbb18a9c@amd.com>
Date:   Wed, 29 Aug 2018 09:37:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829135949.GF6337@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0142.namprd05.prod.outlook.com
 (2603:10b6:803:2c::20) To BN7PR12MB2674.namprd12.prod.outlook.com
 (2603:10b6:408:29::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab766410-03f1-4303-552f-08d60dbcff7a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2674;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;3:njzsfyaI6GmOqETulI4COiccjfTbVHD+7fAsapZturf7LWQl3u36QVABHDJOWnVLlFRquiLDRSGUxxolBLgoQ14URtYQbCTxYphLYAmvad8i+9stcTI1SPMKaRwxb+om0Rr4mm3I4nbs7g5AN/RE1ytAi+uK1K3htsPBZ5i29DXmx50nHeKkD5lKwj0YQIrpmyODfVVj7CTcVEHBbW3f227o1qs9DK657efi5fzkunNZgMBK7R5bS8CxbzayyLrH;25:WJU6mQOJB6HftjDrbXn9H1SCVWSC3snzMEd3A7p2ZXPZv0BvyXQMkSh0z6FSaXPBPmKjZgTKl8+gMDibqZjawVJQhUZZaMzuNwf5sOZ4laHciga3FN/m+G1869+5KlFtTyWC0YXyUyGMGyWhSxCG+Y9vmz51cj1y1QpgQCBaYajd4+Cy1hAF5GEv5qf9nRyBU59RKblQK1rRWCNmB9wmSEjqeqBcZaT0I+OEuFUqdDPCCLGi7aqGE7QYkrKG8BxZOJ9OWzvBrM7lrZRuBCuMiFJff1gRBfxphwqvG2EvMacm1BYbqt28eXjrgkYrys9PhJvtr1eJAZ1UgqjTL8X+9A==;31:GnPcCqQq5JU3kMZtD2HglQzfluT2ATGR9wcfPVH6G4bSUXtHrI6Wf51XFmebMfxlxV0COMK7jTGg+lsPMpwz2N4M7dU51GMJ/+qyx3tw1PqJJZwHCSxkNmAt/yOTH+LjhJgXoywZ5cPn9ZB4zYZhI3akR271LpV7Tx3PXTdyI34trXP75EpGCw354x0eiOPbW+lAWF/Bjhls14/ojt99+WQGPd4lIb0HR+mcMo9AMGk=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2674:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;20:MXrTEGoX6DUxWqYtJiqpC39BBTdZXpWU3lruui2mReQKJIXvjGssD+5SYixSWcjFgU5E0zqNp9ulRwIftER8XWG35Pi8A4D22xLuRXwWzgtcy2dLL00grZ8BQGO6Py2GeIWizd7D5bSUe+O3gn2vFj+PzRVqiaZkHqEF68nTMK/8U516FROaKtQ+ysXDQmzbgGxUrje2zBF3c49Ok1Tws0M2hIEYLYcCCizV/ZcaqLnEUvVz8DyryT6nP9u5U7T1hxjMbMmJeS9s78HozoVUZZgxcUdvJe+lTC8gJvuoNFqnMreUICNy+mvGYqHW8ziQ9PvnM2J1eIz7SZp4MhAzSvuP8M0Wjlr/5GCVHax4w/gh6NkzFbO48zVrXh6yvgncsYQN/P1lIxHK2RyBabMUzG+L2hRQXG2EyGiIxaYGecsXq9Guc0UQMSH1NADv6qWmlkPdFLZ3b2eKN+TpdyHAH63OsKKVjLZYYfrKxywfZDRCsTxhPbO26+71PJsDhQfS;4:VmC2bvdyeaSmA5qhGewo6MTaj2nMWsqkB6jF0tr94zHVOignEC0hbmKaL58+vVIEXmYNu8xAX/o4OgDD1byFgolPouFAQTNV5KucV3Lyut45wI+g6TQX7mhW+WS2zfV/WBAsQQpZ8+vaAhQZTujIXNlbPKjZoMLHQmDNYhIrqnX8mxZVqPHfk1ZrWHK5ZD6zyl5UHI95r6X2P0//qcDJW3+Czw0gDFDwBJELuicCfnoMbCy5yHSuUguxR08tvl/p0a+eC/Pu4/AEzvzEeXKIk4kYyqlU2OcUdoQLB+VRwig2uTi+YhX8OxGmEgFsWyTG2R1R1pdmqH2LSpI5kobBDE6NM2H5+RLPvfcN2YdEsqrk9fkpT3ses522s9GCB9QBpcsZniwwCMeCyDAkJoGPlw==
X-Microsoft-Antispam-PRVS: <BN7PR12MB267496FFF86F866D16BF2A3BE5090@BN7PR12MB2674.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(163750095850)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:BN7PR12MB2674;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2674;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(376002)(396003)(136003)(366004)(43544003)(189003)(199004)(52116002)(8936002)(8676002)(76176011)(2486003)(7736002)(81156014)(305945005)(23676004)(4326008)(25786009)(52146003)(77096007)(3846002)(26005)(6246003)(386003)(58126008)(53546011)(956004)(486006)(16526019)(476003)(6116002)(446003)(11346002)(67846002)(44832011)(54906003)(14444005)(186003)(81166006)(2616005)(229853002)(86362001)(2906002)(575784001)(97736004)(50466002)(2870700001)(106356001)(65826007)(6666003)(6916009)(105586002)(31696002)(31686004)(478600001)(47776003)(68736007)(36756003)(316002)(66066001)(53936002)(65806001)(65956001)(16576012)(64126003)(6486002)(5660300001)(7416002)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2674;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjc0OzIzOjkyL1h0RE5BME05UXY1OGwzR2dES3gyZWFG?=
 =?utf-8?B?WmdJVE5HdStWVFVEK0xteGZ1MFdQN1pNTUZNNmQxNlFhak5IVlNMYnZSUTVR?=
 =?utf-8?B?NVlqT0RFb252Rm5qRGI1K1RKKzlZbjRNbWJaWU5rbm02WjQ4MkFaZGgvZ2Nq?=
 =?utf-8?B?T0NVb05LS1JOaCtqWXZIbG9ZcnZCaGd4V2RxNkF2Zng4Zk1CTjFmbGZnMTBB?=
 =?utf-8?B?Q2Q1QmVJMFlJMmkxYVRrMGZ3dmlWRCtidlNMNXFNWHNDUURVdGRnMWlETUhX?=
 =?utf-8?B?RFhWZitLSHExZHBtVFdneE90d3gzSEtET1dQSmQ5UEJhMEh3YmY2TXJKQWp6?=
 =?utf-8?B?RWJzWWc3QmFtRjV5RlY2dlNrQVp1TkpQZ2VlclpTT250alVXYUlIeGdsQTRI?=
 =?utf-8?B?Zm4yTXFNME5nRi84bVYrUkt1UVRLTEM3dmdxVlJKcElkY0NoV09ZWlVzTDcw?=
 =?utf-8?B?Z0hla2FPSnpEamVBTVp0dnR3dkJ4b3VuR3lvVkI2Um1UeHU4SFBuaElCVTFM?=
 =?utf-8?B?azhGdmlTNHF3Q0dPaHFjSWJGdHhDMkNQY0FqQnNIU1N2RC9jNi94YmV5cFZk?=
 =?utf-8?B?WXFxRzBENFhqNjQxc3Zqek9HWk1FRDluTzVLZGJZVjQ4OEoySThFam1Gd2p2?=
 =?utf-8?B?SW8xTkU0TzVRejJyYmt3STg5OW9oM08vYVppUmpmd01LVmQyL1NCOXQySDZP?=
 =?utf-8?B?OXliczZ4MnZ4MXB1YktsWDJUR0xXQzRHVXU0TkF4RDNpL1JBZjRMdm45SW9n?=
 =?utf-8?B?NnVGNFRJMktqSFNlYzhRRGJwZWtTb25IM3c0QlZCNmNEa1gwaVgrVjZxdmpy?=
 =?utf-8?B?b04xZXF4bm9RVi9JcFZBUTBCUXN6MnZFcXhKZTVVblRHNVZCVkdUSlJySHFx?=
 =?utf-8?B?NElYMVNnMGgwTHhLMTFkZGk3SWdtOVZaQy90eUIzSDJwT1BOaFBjcjQ4QzBX?=
 =?utf-8?B?aUg4b3dFekpaREpTWTc5UnF3R2dWU1NpaytZSTl2b1hzRWRIODd6a1g1QjdH?=
 =?utf-8?B?RkluOHVCSXVjUnBPLytFeWZ6VmpGWmtiVi85eHd2a2RaT2lRU1J2MEErcHRk?=
 =?utf-8?B?UkxrVUltR3hvcUJvNlVRSUpRRUpweWVTRHF6a0dFR01kTUgyM2tOZVpjYU1D?=
 =?utf-8?B?SzRTQ1ZSYVVwdFYwK3BES1RWZzBUTWpGSG5CRHNSbU5Qd0d3aUx6YW9BdGtT?=
 =?utf-8?B?R1JXcjMrMDNqVHlXdEdIbmt3MCs2M3BDRnNkVGtxV1ZqSlBMQzFRNDIvUlNh?=
 =?utf-8?B?UU5zR0x6dzJ4MGtJeFR6TWV4ZXo3K2hmaHkvd3RXOERlUkg1ZFJrM2FyUjFP?=
 =?utf-8?B?Zm9UbFN6bFQweXlIbnduTnpSM2Fra0dId3ltcittSDlsWHJNYmt6QkZjam1o?=
 =?utf-8?B?MWFoR2UxZzZYMjAyM3VZOXcyajFvS29RVHhiK3FPaS91MFpTc3hyTWIxVVhh?=
 =?utf-8?B?NHEzcEd6RXdRSWYyYVU0dUh5di90WnBrUXRmQ1l0dWRqZ1FJMENoUHhDNkJM?=
 =?utf-8?B?eHdLaTF4Qi91Z0tyMlBZaHY2Q0thNVhNMGFwRFcrazJ5K3ljY1p0K2hLdGJF?=
 =?utf-8?B?SnY4UHlLWWhMY1ZtN091ZkIzRVZtcGNuQjhOemFUTU8xdmVjeUhaandOenZz?=
 =?utf-8?B?cW4zMCs0N2E1RmJOVTQ3VmNEcmt2TjhmcCs1a3Izbm9hTitwV1g1Z2MzOG13?=
 =?utf-8?B?RGl6WkJqTDB4cEJWdUZ4T08rZHU3QjMrNk5PbTR4QmF2Q1ltMnVpdkt0RFpI?=
 =?utf-8?B?b082a0lSQjR0bXZDamJic0x4ZklrQkxCYzRpMEJUWHJxUjhpcVdlS0doWGRC?=
 =?utf-8?B?MDdlVkcwOElRTHBLelRKNEZaL1FKaFJ6UEgvbDJhNUhRbjdrQkwzQnppRXZD?=
 =?utf-8?B?S0JrR3VoZVUwOUtkRGFQNXo2SWU5QjhhVFdLemFQcitWV29rUm9iajlSNHFn?=
 =?utf-8?B?Y1pmNmlVaXh5VlJXWHV5UC9rTVRia3U5YUFoLzF0RlJWM2R5Sk1jZ2dmS3pu?=
 =?utf-8?B?VDZqVUY1Sm0rcEY3UmhjZ052bXh2Q2k1VXB1dFZpaU9EV2wzYktlbExRY0wz?=
 =?utf-8?B?dHJiQlVmcVNMK3ZXdU41Q0UrKy9Zb3pLRUttdUFoZGFGTlBWSzJoL3h5cHdT?=
 =?utf-8?Q?G7BBl2ET1nzNQQOUMtqoy6GSc/aZOc6U3D20FHWKt6zn?=
X-Microsoft-Antispam-Message-Info: +z3kQdvcBHChXM0Qpu1CPO3+NoTlcaMozZYCmAT5BtogtK7gbzxqVVB4xpHVHdJpsefs7fq6tOHBO+sCpZl6zA1uZx512kScrj7S1GtOP1pH2EQwCvMf6TTuCOKzVBXZs9kOxiMB8VLd2MeOF+UAxVNaycbORUQxQNGTPcphFZxx4hI4EbaGbg3y4f5QznUqxwc0AR+LUm+7cLLJKtuh6dN63o8eTYwnzGlxPrAwdNrvHiiavtfrVSoX0qaOsQtV6QiVGo1mtVsPRL8eNdMMKYD4+7xQu2pw9+Jjh0cGJ6ilZz7mqRA6mfaNezzWJfur5p/JLAJjIApQhI15gRa+1RzkmYA6x3blaqqddXyL9x0=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;6:kUtr2wnGhPLA/+66aO7+d+rJSKEt+7B0g8glZlew8lgJ9oswEz9W7gUECOpiFWbiUtUo59acN/KIt/HLEhBLn7/Itg+N+ppW5GC7PEC5b+7HK4uSnUYqPTZFqfyiryI+DjxM2MstSZ/iPGDy4bkM/7cynrwyfB5WnkLA0utA9Eb9V4mCgtpcXgf1D/5yYPTwER6ZQ7Dcyzv0QR5WH6jGTYZ14QP6mV5L7VJFY8F9f/qJwUr4FIG1uRc5ZFiXLcNuMeKXF9M+vGkz3e4jWo2ncPFoyA5yYNrm1L5I6ryWdkz72fDUx4JITOPgEvviAEbt6jr4TZk7LMCqizCUGfbZ+u5zl3VvZds12SQOAdQ2ArS+giJYhnFpN5YSsdF9xWqCHg3c67EEtUDKsIi4Oj6sI9pszHG/jJneY5Bvu+LrzIcSoAWWnsL4rGE3rPDahpT2SWqxWvc1Ddrm2EqFbmqmbg==;5:TR/OAaAk649uaxmiEdsxgM0sIUMOsNTAQBrpYUQSw21vZi4gP1L+YGoGqqqpYe28qIthZFhE/WDkgEEbGfhn6rvWHn2xDrmHtGjJQcnBYG4MG5VVmX/Zl7YnV2pc73ip6b5QsEVkkc09c3Ova6yWikHo2ERCVpyTxmA9++LQXUQ=;7:mMJHSTqu479Tg9qZLwZ7gezePQ+eTKs06RyuJ8D4KKziMWEQhGArEqUqe11VNZm12XQWiH81CRdlzxlePlp1RJyo1f12oLZkUyYEWh4ezgsLMmejOD7IE9LSLEDH+oVq7MSx522UgCeF0ETuWRsWx4m487SGiN57oKMF9T5ZYlyZjOD8MVPHjLg+f44sB7y0qJD1knmU9ZNU2w7J0Hu6dpkVuNoJlIp7chS+P7grZQHZomb643jXD+BlITmMGl1K
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;20:Cp6blyTZvDyfVLjdxDEa+6jlbdXac/l7AtXb9VXSuhQm/aiXTFeIuBLjHFxpxkIu17S/xnn+2/xr1vCIb7ctGbKv9obEGStHjj49GX2YPEE7AB/GU1L34oh5EOMefz7IBOCJN4R6MS+kDfEC6c7Cj4r13Gzidl8zSnlOHTdGd/LU7j8F5m1eTnImUIeu0hiXutUEbcaFnhQXZl3BeQnBpryf2a7fnp1xbTKm9Rg4hqdBkSdsexS3Fc3Jqv45iPwb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 14:37:50.3068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab766410-03f1-4303-552f-08d60dbcff7a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2018 08:59 AM, Borislav Petkov wrote:
> On Tue, Aug 28, 2018 at 05:12:56PM -0500, Brijesh Singh wrote:
>> kvmclock defines few static variables which are shared with hypervisor
> 
> 							... with the hypervisor ...
> 
>> during the kvmclock initialization.
>>
>> When SEV is active, memory is encrypted with a guest-specific key, and
>> if guest OS wants to share the memory region with hypervisor then it must
>> clear the C-bit before sharing it. Currently, we use
>> kernel_physical_mapping_init() to split large pages before clearing the
>> C-bit on shared pages. But the kernel_physical_mapping_init fails when
> 
> "But it fails when..."
> 
>> called from the kvmclock initialization (mainly because memblock allocator
>> was not ready).
> 
> "... is not ready that early during boot)."
> 
>> The '__decrypted' can be used to define a shared variable; the variables
> 
> "Add a __decrypted section attribute which can be used when defining
> such shared variable. The so-defined variables will be placed..."
> 
>> will be put in the .data.decryption section. This section is mapped with
> 
> " ... in the .data..decrypted section."
> 
>> C=0 early in the boot, we also ensure that the initialized values are
> 
> "... early during boot,"
> 
>> updated to match with C=0 (i.e perform an in-place decryption). The
>> .data..decrypted section is PMD aligned and sized so that we avoid the
> 
> "... PMD-aligned ..."
> 
>> need to split the large pages when mapping this section.
>>
>> The sme_encrypt_kernel() was used to perform the in-place encryption
>> of the Linux kernel and initrd when SME is active. The routine has been
>> enhanced to decrypt the .data..decryption section for both SME and SEV
>> cases.
> 
> ".data..decrypted"
> 
>>
>> While reusing the sme_populate_pgd() we found that the function does not
>> update the flags if the pte/pmd entry already exists. The patch updates
>> the function to take care of it.
> 
> 
> Change the tone to impartial:
> 
> "While at it, fix sme_populate_pgd() to update page flags if the PMD/PTE
> entry already exists."
> 
> And avoid using "This patch" - what this patch does, should be visible
> to the enlightened onlooker.
> 


Thanks Boris, I will incorporate your edits in commit message.


>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Cc: stable@vger.kernel.org
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: kvm@vger.kernel.org
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>> Cc: kvm@vger.kernel.org
>> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
>> ---
>>   arch/x86/include/asm/mem_encrypt.h |   6 +++
>>   arch/x86/kernel/head64.c           |   9 ++++
>>   arch/x86/kernel/vmlinux.lds.S      |  17 +++++++
>>   arch/x86/mm/mem_encrypt_identity.c | 100 +++++++++++++++++++++++++++++--------
>>   4 files changed, 112 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
>> index c064383..802b2eb 100644
>> --- a/arch/x86/include/asm/mem_encrypt.h
>> +++ b/arch/x86/include/asm/mem_encrypt.h
>> @@ -52,6 +52,8 @@ void __init mem_encrypt_init(void);
>>   bool sme_active(void);
>>   bool sev_active(void);
>>   
>> +#define __decrypted __attribute__((__section__(".data..decrypted")))
>> +
>>   #else	/* !CONFIG_AMD_MEM_ENCRYPT */
>>   
>>   #define sme_me_mask	0ULL
>> @@ -77,6 +79,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
>>   static inline int __init
>>   early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
>>   
>> +#define __decrypted
>> +
>>   #endif	/* CONFIG_AMD_MEM_ENCRYPT */
>>   
>>   /*
>> @@ -88,6 +92,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
>>   #define __sme_pa(x)		(__pa(x) | sme_me_mask)
>>   #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
>>   
>> +extern char __start_data_decrypted[], __end_data_decrypted[];
>> +
>>   #endif	/* __ASSEMBLY__ */
>>   
>>   #endif	/* __X86_MEM_ENCRYPT_H__ */
>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>> index 8047379..3e03129 100644
>> --- a/arch/x86/kernel/head64.c
>> +++ b/arch/x86/kernel/head64.c
>> @@ -112,6 +112,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>>   unsigned long __head __startup_64(unsigned long physaddr,
>>   				  struct boot_params *bp)
>>   {
>> +	unsigned long vaddr, vaddr_end;
>>   	unsigned long load_delta, *p;
>>   	unsigned long pgtable_flags;
>>   	pgdval_t *pgd;
>> @@ -234,6 +235,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
>>   	/* Encrypt the kernel and related (if SME is active) */
>>   	sme_encrypt_kernel(bp);
>>   
>> +	/* Clear the memory encryption mask from the decrypted section */
> 
> End sentences with a fullstop.


Noted.

> 
>> +	vaddr = (unsigned long)__start_data_decrypted;
>> +	vaddr_end = (unsigned long)__end_data_decrypted;
>> +	for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>> +		i = pmd_index(vaddr);
>> +		pmd[i] -= sme_get_me_mask();
>> +	}
> 
> This needs to be no-op on !SME machines. Hint: if (sme_active())...

Sure, I will add the check before calling this loop.

> 
>>   	/*
>>   	 * Return the SME encryption mask (if SME is active) to be used as a
>>   	 * modifier for the initial pgdir entry programmed into CR3.
>> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
>> index 8bde0a4..0ef9320 100644
>> --- a/arch/x86/kernel/vmlinux.lds.S
>> +++ b/arch/x86/kernel/vmlinux.lds.S
>> @@ -89,6 +89,21 @@ PHDRS {
>>   	note PT_NOTE FLAGS(0);          /* ___ */
>>   }
>>   
>> +/*
>> + * This section contains data which will be mapped as decrypted. Memory
>> + * encryption operates on a page basis. But we make this section a pmd
> 
> "... make this section PMD-aligned ..."
> 
> Also, avoid the "we" and formulate in passive voic


Noted.


> 
>> + * aligned to avoid spliting the pages while mapping the section early.
>> + *
>> + * Note: We use a separate section so that only this section gets
>> + * decrypted to avoid exposing more than we wish.
>> + */
>> +#define DATA_DECRYPTED_SECTION						\
> 
> DATA_DECRYPTED is perfectly fine.


Noted.

> 
>> +	. = ALIGN(PMD_SIZE);						\
>> +	__start_data_decrypted = .;					\
>> +	*(.data..decrypted);						\
>> +	. = ALIGN(PMD_SIZE);						\
>> +	__end_data_decrypted = .;					\
>> +
>>   SECTIONS
>>   {
>>   #ifdef CONFIG_X86_32
>> @@ -171,6 +186,8 @@ SECTIONS
>>   		/* rarely changed data like cpu maps */
>>   		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
>>   
>> +		DATA_DECRYPTED_SECTION
>> +
>>   		/* End of data section */
>>   		_edata = .;
>>   	} :data
>> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
>> index bf6097e..88c1cce 100644
>> --- a/arch/x86/mm/mem_encrypt_identity.c
>> +++ b/arch/x86/mm/mem_encrypt_identity.c
>> @@ -51,6 +51,8 @@
>>   				 (_PAGE_PAT | _PAGE_PWT))
>>   
>>   #define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
>> +#define PMD_FLAGS_ENC_WP	((PMD_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
>> +				 (_PAGE_PAT | _PAGE_PWT))
>>   
>>   #define PTE_FLAGS		(__PAGE_KERNEL_EXEC & ~_PAGE_GLOBAL)
>>   
>> @@ -59,6 +61,8 @@
>>   				 (_PAGE_PAT | _PAGE_PWT))
>>   
>>   #define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
>> +#define PTE_FLAGS_ENC_WP	((PTE_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
>> +				 (_PAGE_PAT | _PAGE_PWT))
>>   
>>   struct sme_populate_pgd_data {
>>   	void    *pgtable_area;
>> @@ -154,9 +158,6 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
>>   		return;
>>   
>>   	pmd = pmd_offset(pud, ppd->vaddr);
>> -	if (pmd_large(*pmd))
>> -		return;
>> -
>>   	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
>>   }
>>   
>> @@ -182,8 +183,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
>>   		return;
>>   
>>   	pte = pte_offset_map(pmd, ppd->vaddr);
>> -	if (pte_none(*pte))
>> -		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
>> +	set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
>>   }
>>   
> 
> This looks like it belongs in a prepatch fix.


Sure, I can do a prepatch for this change.


> 
>>   static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
>> @@ -235,6 +235,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
>>   	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
>>   }
>>   
>> +static void __init sme_map_range_encrypted_wp(struct sme_populate_pgd_data *ppd)
>> +{
>> +	__sme_map_range(ppd, PMD_FLAGS_ENC_WP, PTE_FLAGS_ENC_WP);
>> +}
>> +
>>   static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
>>   {
>>   	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
> 
> These changes with the _WP flags and helper addition belong in a pre-patch.
> 
>> @@ -382,7 +387,10 @@ static void __init build_workarea_map(struct boot_params *bp,
>>   	ppd->paddr = workarea_start;
>>   	ppd->vaddr = workarea_start;
>>   	ppd->vaddr_end = workarea_end;
>> -	sme_map_range_decrypted(ppd);
>> +	if (sev_active())
>> +		sme_map_range_encrypted(ppd);
>> +	else
>> +		sme_map_range_decrypted(ppd);
>>   
>>   	/* Flush the TLB - no globals so cr3 is enough */
>>   	native_write_cr3(__native_read_cr3());
>> @@ -439,16 +447,27 @@ static void __init build_workarea_map(struct boot_params *bp,
>>   		sme_map_range_decrypted_wp(ppd);
>>   	}
>>   
>> -	/* Add decrypted workarea mappings to both kernel mappings */
>> +	/*
>> +	 * When SEV is active, kernel is already encrypted hence mapping
>> +	 * the initial workarea_start as encrypted. When SME is active,
>> +	 * the kernel is not encrypted hence add a decrypted workarea
> 
> s/ a//

Noted.


> 
>> +	 * mappings to both kernel mappings.
>> +	 */
>>   	ppd->paddr = workarea_start;
>>   	ppd->vaddr = workarea_start;
>>   	ppd->vaddr_end = workarea_end;
>> -	sme_map_range_decrypted(ppd);
>> +	if (sev_active())
>> +		sme_map_range_encrypted(ppd);
>> +	else
>> +		sme_map_range_decrypted(ppd);
>>   
>>   	ppd->paddr = workarea_start;
>>   	ppd->vaddr = workarea_start + decrypted_base;
>>   	ppd->vaddr_end = workarea_end + decrypted_base;
>> -	sme_map_range_decrypted(ppd);
>> +	if (sev_active())
>> +		sme_map_range_encrypted(ppd);
>> +	else
>> +		sme_map_range_decrypted(ppd);
>>   
>>   	wa->kernel_start = kernel_start;
>>   	wa->kernel_end = kernel_end;
>> @@ -491,28 +510,69 @@ static void __init remove_workarea_map(struct sme_workarea_data *wa,
>>   	native_write_cr3(__native_read_cr3());
>>   }
>>   
>> +static void __init decrypt_data_decrypted_section(struct sme_workarea_data *wa,
> 
> That function name could use some clarifying change...


How about decrypt_shared_data() ?


> 
>> +						  struct sme_populate_pgd_data *ppd)
>> +{
>> +	unsigned long decrypted_start, decrypted_end, decrypted_len;
>> +
>> +	/* Physical addresses of decrypted data section */
>> +	decrypted_start = __pa_symbol(__start_data_decrypted);
>> +	decrypted_end = ALIGN(__pa_symbol(__end_data_decrypted), PMD_PAGE_SIZE);
>> +	decrypted_len = decrypted_end - decrypted_start;
>> +
>> +	if (!decrypted_len)
>> +		return;
>> +
>> +	/* Add decrypted mapping for the section (identity) */
>> +	ppd->paddr = decrypted_start;
>> +	ppd->vaddr = decrypted_start;
>> +	ppd->vaddr_end = decrypted_end;
>> +	sme_map_range_decrypted(ppd);
>> +
>> +	/* Add encrypted-wp mapping for the section (non-identity) */
>> +	ppd->paddr = decrypted_start;
>> +	ppd->vaddr = decrypted_start + wa->decrypted_base;
>> +	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
>> +	sme_map_range_encrypted_wp(ppd);
>> +
>> +	/* Perform in-place decryption */
>> +	sme_encrypt_execute(decrypted_start,
>> +			    decrypted_start + wa->decrypted_base,
>> +			    decrypted_len, wa->workarea_start,
>> +			    (unsigned long)ppd->pgd);
>> +
>> +	ppd->vaddr = decrypted_start + wa->decrypted_base;
>> +	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
>> +	sme_clear_pgd(ppd);
>> +}
>> +
>>   void __init sme_encrypt_kernel(struct boot_params *bp)
>>   {
>>   	struct sme_populate_pgd_data ppd;
>>   	struct sme_workarea_data wa;
>>   
>> -	if (!sme_active())
>> +	if (!mem_encrypt_active())
>>   		return;
>>   
>>   	build_workarea_map(bp, &wa, &ppd);
>>   
>> -	/* When SEV is active, encrypt kernel and initrd */
>> -	sme_encrypt_execute(wa.kernel_start,
>> -			    wa.kernel_start + wa.decrypted_base,
>> -			    wa.kernel_len, wa.workarea_start,
>> -			    (unsigned long)ppd.pgd);
>> -
>> -	if (wa.initrd_len)
>> -		sme_encrypt_execute(wa.initrd_start,
>> -				    wa.initrd_start + wa.decrypted_base,
>> -				    wa.initrd_len, wa.workarea_start,
>> +	/* When SME is active, encrypt kernel and initrd */
>> +	if (sme_active()) {
>> +		sme_encrypt_execute(wa.kernel_start,
>> +				    wa.kernel_start + wa.decrypted_base,
>> +				    wa.kernel_len, wa.workarea_start,
>>   				    (unsigned long)ppd.pgd);
>>   
>> +		if (wa.initrd_len)
>> +			sme_encrypt_execute(wa.initrd_start,
>> +					    wa.initrd_start + wa.decrypted_base,
>> +					    wa.initrd_len, wa.workarea_start,
>> +					    (unsigned long)ppd.pgd);
>> +	}
>> +
>> +	/* Decrypt the contents of .data..decrypted section */
>> +	decrypt_data_decrypted_section(&wa, &ppd);
>> +
>>   	remove_workarea_map(&wa, &ppd);
>>   }
>>   
>> -- 
>> 2.7.4
>>
> 
