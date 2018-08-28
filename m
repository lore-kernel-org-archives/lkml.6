Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF3DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C9A20897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qEMRlIkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C9A20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeH1VGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:06:36 -0400
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:36503
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727020AbeH1VGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h74SUhWiBDIXMOXZOn81C+URZNK4j68t51m/MUPgHNY=;
 b=qEMRlIkLmxlV+eXPCICSQVvW4vtSB6tXUlWei9fTEajncnbU1i1DER6dMAnqY1X3FH7d7TxILxTHUZL+PhqymMvJpUqIfiX3VM12/aCOtFpSKz+0lwMvPnJzp9KT9OzvLv3a8rXAWUFrZEMEbtYzAW27/vOEYxN2WnBrg2+K48s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BN7PR12MB2675.namprd12.prod.outlook.com (2603:10b6:408:29::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 17:13:33 +0000
Cc:     brijesh.singh@amd.com, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 1/2] x86/mm: add .data..decrypted section to hold shared
 variables
To:     Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1535369080-20290-1-git-send-email-brijesh.singh@amd.com>
 <1535369080-20290-2-git-send-email-brijesh.singh@amd.com>
 <8c7250e6-c7f6-cfcd-08f8-fd35a829f032@amd.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9b6f974b-dcb3-3668-c83b-308abf33e85a@amd.com>
Date:   Tue, 28 Aug 2018 12:13:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8c7250e6-c7f6-cfcd-08f8-fd35a829f032@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0107.namprd05.prod.outlook.com
 (2603:10b6:803:42::24) To BN7PR12MB2675.namprd12.prod.outlook.com
 (2603:10b6:408:29::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd0debeb-855b-4da1-af4f-08d60d09962e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;3:6Fsx7H+nJo2v2Zp+U9LMWLV+On7/rQhPLkm+eguItsawl8j+nAbWcaZG+MvCFhpDwF4W1TyudnybzfWsjWrLeUjlWCsg4PO/n0iAE9GG+SGdKFFxCcKTx4y58n9ayqfd2baJ/FoElTL9PjwUdqAcbLb3HK7Rmv/nPY8UCqVFryoW8csEf/UsouwAksYiMxiKyzC52TQp8Q3Jzdo+wPfP+r7W5ukGdyKt2mrpLnWVpa7I+J6gGPoiwX5vlX8SOyYl;25:K32f6JtlCY2BLdNzIC3ADZcYJBZYUfMR6b80612waNSWvd7kYPZpQxBzJNfv+AQc4c41qYnxbM8NfPcvHn1SBYYuiu4FWfYCPQsTWsHPPOQYtTjmcoRaerTWNpaPCITypHAX90jD/JtRAKVy5s5NWKsQaXNaKz9ouotvomMs8G1d5imrgjF6ah9yuVI9K90rv65w12gzcXeEbd7fJOPMAATDvqTtcHhDawi00BbhT0Tto2SgeicB34Xm5NqcnDIbUh/8UlSoPHZlgTJyGmmc0Z2rm4xSVnmvnV46eNd10WLDxdl05Q1ISyL3seuKuoFGTyuvx5DJrGaUPb/AFVt4Pw==;31:MrBktin8H2r2XKGw4Luz34YoyzMkqOCTaJYrH/jizCKYsobI56jWxaHFh+odDfTH/kRVACDzhZ8gg6Iym7+tKqsI6CbiZBZ4qwuD/nw68lCSDwLd0KrVa/8E+g1/Qvsaj1jquI1Z7+6ztKQ0cWjZ+U+m2rpFcm6d46RENDQPP5u7+Lfu8K9JvvNP+0t2BK7FfCT7LCCkaSPHrZbQDiv0tbFFv6WUWCwWeyavNrRzMoI=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:b+jlZt22o+F6XQTxVQlRUFxARjRp7DKFhdM24PpgVO8BVr3WQDm11FozSe10X1vtA+j90jU5kzT6dS1J+rO6J+h2LMDtQGe4lzBa9/WJJPRKIVpyB7jyONjVyuVK+TekPtj8mV64Lh31keNuTLjHjXVRyow0WjYvPpBzb+BuRTDpn8chWt/IAR6Oy23nH6VhsSqSeFaKpfligVdL6V86W5Hf7TuDuViV6EkepLL6898yMtVIdnOKxAkMhL5CKCt7kEg3t7XV+azkznthndn6gVNs6fiN+D6hcNEA2qtxonCwxSCRsxZUuAN+QpiDHgOXFipB5k2o6UpVNcMhE0dgdBdcX00NrIJqAXVuEp03r7LV90XuTHnLoBbr3DgllC+9H5N+zNMXuAhgHxS88tCYVl4+KJEtKD1msepgQE1ne8MM3C6t2NvviW/HKT6x2iny0Bw5mO4MtnNG4slYaFbIjJnb1kc1OuUSUco1qdF5J10JitkDRjpCMNPvHXE7jPh9;4:jwgaNxp9snYlxwZTSvWENEM3+b8CF7qaU7jydXKTwmPp2KLmckz7gjCSmagAD8M4pjSPx7Yl9vGW2pkRecl/j6ht8WHMdYWQa90hkMur/5OcIq9E/M9eP3NhxVw/JiAq74izHLFqi1E40X4vZ5BHzpW9GnI3+G+7XMIvnHwVMVxtEgjVgDyscRrEN0521ds76vgKMESfIq2RINT7NzQl4YhC36xGOypovE/zZ0J/7qeTDO5om3RGL5wjW0m7UHX9Ywgsx50kOOuMcZjqkEkYpMN+Ky/aiRKydN+6jgryqaAjtPh7hDuqBk2sWtXO1iyl365u0F5fGvw18xIPkS2aMiZZ3UQFp6pa6VMgycTqbQNZKtw/6N7ZeBfyaq81YQy82BsDH6GpMpA0ngJpQS41/w==
X-Microsoft-Antispam-PRVS: <BN7PR12MB2675969BC92B011E85431692E50A0@BN7PR12MB2675.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(163750095850)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:BN7PR12MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2675;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(81166006)(7416002)(25786009)(23676004)(54906003)(31696002)(4326008)(956004)(86362001)(575784001)(6246003)(65826007)(476003)(5660300001)(64126003)(52146003)(36756003)(16576012)(14444005)(305945005)(8936002)(316002)(2616005)(81156014)(3846002)(7736002)(11346002)(486006)(8676002)(446003)(68736007)(67846002)(6116002)(65806001)(6486002)(77096007)(47776003)(16526019)(386003)(53546011)(229853002)(186003)(44832011)(58126008)(66066001)(26005)(65956001)(31686004)(2906002)(478600001)(76176011)(50466002)(53936002)(2870700001)(105586002)(97736004)(52116002)(106356001)(2486003)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2675;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjc1OzIzOk9lQ1VnajZ0eUdVbnJyT2YydHZoQ2JHOW55?=
 =?utf-8?B?UTVGWXVwZXo5MlpqNVV3cmVZcHBlWTZNMWQxU0gvVytnM2FNTXBhbHlvZWxt?=
 =?utf-8?B?SE9qSVhDVkJyTFd3YlNhVGVGWnZYRktIcERqZ0ZMcytFaHpqYk1DbkZTOTdl?=
 =?utf-8?B?Tkp0SDV3R1RBVVNCeGpXVXdIK2cxclFhaUtRcDlEanJIcms3RThPcnRuMWRo?=
 =?utf-8?B?L3ZzNlc3WFREVHFLVFM0Tk5wckRpOW1jQUhRUXd6VHA4ODBNcXdVdlpXL1Yy?=
 =?utf-8?B?NTYxMmxoRDVZd1A4WW5sa2E4QVBaMHJMakxXRjF2T2ZlY1ZudkxCcUNuNE5X?=
 =?utf-8?B?UForcno3Q1VrcmZBdTRVYnBwK3VSTFFlVFVhdmZNSmpPeUNsYzh2VXZleVNH?=
 =?utf-8?B?UmhtNHVNbWk5MzlBeHJ1aXA5eElsYW5xNUZIczR6empTWUxpK0RFL1czYzJX?=
 =?utf-8?B?dGprVk5jVXJkandjR1owTEZoYkNLemE4dUJJTHFzU0VjMTlLY09vS0J3Y2Mr?=
 =?utf-8?B?Qk1ZNFVGZjh1NStZbWpLVFVxSm9tLytsMXZZMXl5WVU2SGZKVVBHRzdscDdR?=
 =?utf-8?B?THljS3k1Vmc2Z2JiR2RYekpCZko3M014bFUvQm5tem1TWGh3TmFxbHUvM2dr?=
 =?utf-8?B?SVl6bDZUWlo2K3daTlJrQWdQeFIwNkd2SXNrMzUrYjZ3OTA5bkJzTTZJRkxi?=
 =?utf-8?B?UmZ6bGJ0ZDRDTmg4YW5WQXNhWGpVK0tnVy96alJ2OWw1TitwaHpSYzhCakZ1?=
 =?utf-8?B?azdsQllsWDVaVDBSOHhSS1J0Y2VpU3RETXRObXZtaGIyelhNdWtsNzByV1dz?=
 =?utf-8?B?cGJPeGJFM0o0ZnNJdEhFUGE0dVljb0JLbHhiSWI2c3Arb042WHhHbXJIU0pq?=
 =?utf-8?B?VU0vZEdVc3pXd0NkbWdsREJ4V3c5ak1uUnhaaUlwSENiTnY5YjJUYkpjcXZM?=
 =?utf-8?B?Ris5MUQ2czZ2Sjl6VWJjLzVSY0JzMzUwVFhQRUhENEtZcy9Bbkd2NUxrZGFp?=
 =?utf-8?B?RFJndWFuUTdqU2lkWHhpbXBZZVhwbnZvYWVjaDhyUWh6VW1KNGIvY0kvR3lC?=
 =?utf-8?B?Q0ZGM21tbGVrRlFKeEhrOUt5Y0FUWFNaeGhoNThucmxKM2lWTDBmdThmUHc1?=
 =?utf-8?B?WHQyczZSb052RDdIRVBid0Q5NG1VK3BjSDdYaDUyai9GNWlLOGpEYlNmZElH?=
 =?utf-8?B?R3Y1M2ZQaVR4WXhJZ2hNRDN0bSsrdHl3OEltN2hqZ0VQbjFCeGhybmJCUE9l?=
 =?utf-8?B?dVY4aG52RU9NLzA5WGhtbTR2b3BKU2ZlUlVPbWNLelEzN1VnVU84TUxuVHRL?=
 =?utf-8?B?UHFtNUNMKzJVY2tJNitrYWVrTEoxcGlLM0gvRjJvMUZldFQxaHRyTUZRNGdV?=
 =?utf-8?B?a0tuUEt0WlhwMTkybnR0WG5ETFVzWDQyR1R0WTFLSUxsbXIxTGJRMzE0Z2sw?=
 =?utf-8?B?d2NndmFxZ3hHa1hwMGljS3U5TUE0L2hYa3RHMTE3VU5TNG9kSCswSndzTFVD?=
 =?utf-8?B?WDZ3LzdsVmtiZmRVYnM5aGxyaC9LSzYxemJHdjZHRm9OVnNzNG0wOFVvbUp1?=
 =?utf-8?B?Y2hFc3Jvbkl1ZS95bWVzMGttakhHdVhjaVdQdm9Kd0tlTWFHcmZETWNMcnpD?=
 =?utf-8?B?b3ZHVXhteVhuUE80enZ1Z1RMbElmNmZnQ0ZEZ3RwdFhwV0p4K2Q1NDNyK3NR?=
 =?utf-8?B?d2hZU3gwNTljNWV4eEM2Z0RNKzJWUHB0dTBzN1E0YU5HYkxIbmR5Nm1xZ0RH?=
 =?utf-8?B?c0pKYkVlWXdxRmhvazhlL1FxZkJDVDVUQlBCOVpQTXhQaHkram5mMlRDQWZn?=
 =?utf-8?B?MXhCS0xkbm5TampKdGNRdHdPTXRrV3RYc2g4Z3pYMld6SWFtdjJNWVdBMnow?=
 =?utf-8?B?dEt0M2VjZDh5Z0pHdHpvbnlkQnphRkQ2V1MxOVovWU1HR09yV0RIVGNFSmlS?=
 =?utf-8?B?THlIOTZ1cWI1REpqUnBpSHFLQndlM29pYkYvbW5rNFB3SU0xYXVxNlQ1Z1Fx?=
 =?utf-8?B?ZkF3UStKK2RsUDFqRWpkdGl2SzE1VGVncDdUMGNMVUVuT1RtTG53ZDJaTHhN?=
 =?utf-8?B?RWhrVDYwQkZIQzIvOWtubEpyOHdtWHRFZUpFNzg1czVpdWpUZ2c1MTBvUU01?=
 =?utf-8?B?YWc9PQ==?=
X-Microsoft-Antispam-Message-Info: lk9MG5HGyO1ZBOVnLf1goGeR9pw0dDq5bO6DVd0zZ7AiCl6+K1rVoGscm3yi9a6v5RovfzHjQ35HQaiksTiplUeXo/A3S6CkASQd9bTKpS620kB5westBJxsi03arOBT8gk7Jur9X9SlHBBa81aPdcIXOLBdw1kPLCq7jF2tKr5CZV3b0iSn7SDj3qbbJPDbpsVHkw4uyD403RlsukQ5ZzfmtUpb1TkrQ8WBcgz7VqaWmh29RAuhgbcJDgLAiV3BLGz7gsupa//3sj7CPcrAZ3cAXrru1GjApFVuHOWfvsQeMzT9gxWANEphUVZ0P4gpxuK84t0of+K3s+eAjb0ITm18IaccNkDMwpGKxSTVskI=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;6:OsYB+Icim4uZD13hH7GCUfZLyzmoA/nKfgXwNJkVrH0NVn6eCYbciIX8UeTqGyxkXu+pyRhrTpyZVkvCJPy6LsxnC24Roavxa8NEDOCyqvw1Zn1QoPwbUFD7GFVbGygyiImJBg3CmslI5xqejZiyKHs/kH9Mo6vWNVOi6gtm2dJsHfi+Tfql9Sc85d8x5AMUQs4wogpSYt9//quqrcWWOAW0ZPIV7xUhCpZIOeo/x/ZdeShxdMIQrj6+Viaa15PF/e8EALgyEN9rR4NLUgST17U5WTfIDNDBHowOObqHdrQ3SZizZaRS4Yob+NonvOOzXh3F8c+u/f6xsxLtf8+KFfE5xUanjShRYfgLTuC8MaVA5QxofmuD45es5ogSI2DpoIB2L1x0XzpuTxN2TfoMerudZdQPWDmy5uyQKfvH125RZfnAegQsVoQwXcaHMG1Xl7XfZHllD3yXi1Q56qIw/w==;5:thTfTZce5DjttiVKtIx6NuNhD25nzlLx5pTojbUloj8oMmGgey0Y0gl5H5pTYjCySsBztD3bBOFZhEeGBxvjPZNtjU7WlB2uRngZLm2ZNHeLBB38cJK6JoYjjOkWVsObwiNPCxCNIO9wJ0Mt/uNNh3Z6USDsvPr0suQ5NP4esJk=;7:Cif/3AC2tyQKZdNoG1fTWdm5Km6bq7pzIikWCqDctSdwRzf4QVgKSELBnDY5ttDCTr1iYBScpaqoOfTxmbMJAJeNqMS3VETxHsFvlbVAECXGuCZT2N7TJeaykJcHW4kMUEf9E6QCfPsGnZD0Y2z3gT7VlyfEaS4FwOxpaTyPqHVkH8+L1i9Ce40TouxUjzUnFUPeJh+4vbcxhx5/+P9CMZSdTljfRydei5T3X7KakPqSk6Iqcf6Ms42V1AGeeTwW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:AZLEGT8kWfjrPgDQ1dKBPFF9TxGAj2qE3X74GlUo/Q9qanP0K8EDswl+nkQsr/V0yShL3wvSfkQbLgaKhNGzyxB5Ml+Dx4a0HCSKrNIwvVczIbURRDgTCRfhzcaSftKJ4bzm9QVW0Fkydr4C5YVOnG6w0BeMjIG3s7bueuzdFejM8UHPft2sEh0k2nRg+MK8W6BvSZeLRnuwYRUeDnE7vj5BOhZ+pCKUYpUbEh+LgpBBRe06EgQwxSa7NT5wxd0p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 17:13:33.3214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0debeb-855b-4da1-af4f-08d60d09962e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/27/2018 05:11 PM, Tom Lendacky wrote:
> On 08/27/2018 06:24 AM, Brijesh Singh wrote:
>> kvmclock defines few static variables which are shared with hypervisor
>> during the kvmclock initialization.
>>
>> When SEV is active, memory is encrypted with a guest-specific key, and
>> if guest OS wants to share the memory region with hypervisor then it must
>> clear the C-bit before sharing it.
>>
>> The '__decrypted' can be used to define a shared variables; the variables
>> will be put in the .data.decryption section. This section is mapped with
>> C=0 early in the boot, we also ensure that the initialized values are
>> updated to match with C=0 (i.e peform an in-place decryption). The
>> .data..decrypted section is PMD aligned and sized so that we avoid the
>> need for spliting the pages when map with C=0.
> 
> This should probably be broken into a few smaller patches.  Maybe a
> patch that adds the section and the attribute, a patch that re-arranges
> the mapping setup and then the in-place decryption and clearing of the
> encryption bit for the area.
> 


OK, I will break the patch. Probably will create a separate patch which
just re-arranges the mapping setup without making any logical changes.


>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
>> Cc: stable@vger.kernel.org
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: kvm@vger.kernel.org
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
>> ---
>>   arch/x86/include/asm/mem_encrypt.h |   4 +
>>   arch/x86/kernel/head64.c           |  12 ++
>>   arch/x86/kernel/vmlinux.lds.S      |  18 +++
>>   arch/x86/mm/mem_encrypt_identity.c | 220 +++++++++++++++++++++++++++----------
>>   4 files changed, 197 insertions(+), 57 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
>> index c064383..3f7d9d3 100644
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
>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>> index 8047379..6a18297 100644
>> --- a/arch/x86/kernel/head64.c
>> +++ b/arch/x86/kernel/head64.c
>> @@ -43,6 +43,9 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
>>   static unsigned int __initdata next_early_pgt;
>>   pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
>>   
>> +/* To clear memory encryption mask from the decrypted section */
>> +extern char __start_data_decrypted[], __end_data_decrypted[];
>> +
> 
> Should find a header for these rather than defining them here.
> 

OK, will move then in mem_encrypt.h. Will that work ?


>>   #ifdef CONFIG_X86_5LEVEL
>>   unsigned int __pgtable_l5_enabled __ro_after_init;
>>   unsigned int pgdir_shift __ro_after_init = 39;
>> @@ -112,6 +115,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>>   unsigned long __head __startup_64(unsigned long physaddr,
>>   				  struct boot_params *bp)
>>   {
>> +	unsigned long vaddr, vaddr_end;
>>   	unsigned long load_delta, *p;
>>   	unsigned long pgtable_flags;
>>   	pgdval_t *pgd;
>> @@ -234,6 +238,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
>>   	/* Encrypt the kernel and related (if SME is active) */
>>   	sme_encrypt_kernel(bp);
>>   
>> +	/* Clear the memory encryption mask from the decrypted section */
>> +	vaddr = (unsigned long)__start_data_decrypted;
>> +	vaddr_end = (unsigned long)__end_data_decrypted;
>> +	for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>> +		i = pmd_index(vaddr);
>> +		pmd[i] -= sme_get_me_mask();
>> +	}
>> +
>>   	/*
>>   	 * Return the SME encryption mask (if SME is active) to be used as a
>>   	 * modifier for the initial pgdir entry programmed into CR3.
>> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
>> index 8bde0a4..511b875 100644
>> --- a/arch/x86/kernel/vmlinux.lds.S
>> +++ b/arch/x86/kernel/vmlinux.lds.S
>> @@ -89,6 +89,22 @@ PHDRS {
>>   	note PT_NOTE FLAGS(0);          /* ___ */
>>   }
>>   
>> +/*
>> + * This section contains data which will be mapped as decrypted. Memory
>> + * encryption operates on a page basis. But we make this section a pmd
>> + * aligned to avoid spliting the pages while mapping the section early.
>> + *
>> + * Note: We use a separate section so that only this section gets
>> + * decrypted to avoid exposing more than we wish.
>> + */
>> +#define DATA_DECRYPTED_SECTION						\
>> +	. = ALIGN(PMD_SIZE);						\
>> +	__start_data_decrypted = .;					\
>> +	*(.data..decrypted);						\
>> +	__end_data_decrypted = .;					\
>> +	. = ALIGN(PMD_SIZE);						\
>> +
>> +
>>   SECTIONS
>>   {
>>   #ifdef CONFIG_X86_32
>> @@ -171,6 +187,8 @@ SECTIONS
>>   		/* rarely changed data like cpu maps */
>>   		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
>>   
>> +		DATA_DECRYPTED_SECTION
>> +
>>   		/* End of data section */
>>   		_edata = .;
>>   	} :data
>> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
>> index 7ae3686..ccf6e2b 100644
>> --- a/arch/x86/mm/mem_encrypt_identity.c
>> +++ b/arch/x86/mm/mem_encrypt_identity.c
>> @@ -59,6 +59,8 @@
>>   				 (_PAGE_PAT | _PAGE_PWT))
>>   
>>   #define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
>> +#define PTE_FLAGS_ENC_WP	((PTE_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
>> +				 (_PAGE_PAT | _PAGE_PWT))
>>   
>>   struct sme_populate_pgd_data {
>>   	void    *pgtable_area;
>> @@ -72,10 +74,28 @@ struct sme_populate_pgd_data {
>>   	unsigned long vaddr_end;
>>   };
>>   
>> +struct sme_workarea_data {
>> +	unsigned long kernel_start;
>> +	unsigned long kernel_end;
>> +	unsigned long kernel_len;
>> +
>> +	unsigned long initrd_start;
>> +	unsigned long initrd_end;
>> +	unsigned long initrd_len;
>> +
>> +	unsigned long workarea_start;
>> +	unsigned long workarea_end;
>> +	unsigned long workarea_len;
>> +
>> +	unsigned long decrypted_base;
>> +};
>> +
>>   static char sme_cmdline_arg[] __initdata = "mem_encrypt";
>>   static char sme_cmdline_on[]  __initdata = "on";
>>   static char sme_cmdline_off[] __initdata = "off";
>>   
>> +extern char __start_data_decrypted[], __end_data_decrypted[];
>> +
> 
> Same comment from above.
> 
>>   static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
>>   {
>>   	unsigned long pgd_start, pgd_end, pgd_size;
>> @@ -219,6 +239,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
>>   	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
>>   }
>>   
>> +static void __init sme_map_range_encrypted_wp(struct sme_populate_pgd_data *ppd)
>> +{
>> +	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC_WP);
>> +}
>> +
>>   static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
>>   {
>>   	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
>> @@ -266,19 +291,17 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
>>   	return entries + tables;
>>   }
>>   
>> -void __init sme_encrypt_kernel(struct boot_params *bp)
>> +static void __init build_workarea_map(struct boot_params *bp,
>> +				      struct sme_workarea_data *wa,
>> +				      struct sme_populate_pgd_data *ppd)
>>   {
>>   	unsigned long workarea_start, workarea_end, workarea_len;
>>   	unsigned long execute_start, execute_end, execute_len;
>>   	unsigned long kernel_start, kernel_end, kernel_len;
>>   	unsigned long initrd_start, initrd_end, initrd_len;
>> -	struct sme_populate_pgd_data ppd;
>>   	unsigned long pgtable_area_len;
>>   	unsigned long decrypted_base;
>>   
>> -	if (!sme_active())
>> -		return;
>> -
>>   	/*
>>   	 * Prepare for encrypting the kernel and initrd by building new
>>   	 * pagetables with the necessary attributes needed to encrypt the
>> @@ -358,17 +381,17 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>>   	 * pagetables and when the new encrypted and decrypted kernel
>>   	 * mappings are populated.
>>   	 */
>> -	ppd.pgtable_area = (void *)execute_end;
>> +	ppd->pgtable_area = (void *)execute_end;
>>   
>>   	/*
>>   	 * Make sure the current pagetable structure has entries for
>>   	 * addressing the workarea.
>>   	 */
>> -	ppd.pgd = (pgd_t *)native_read_cr3_pa();
>> -	ppd.paddr = workarea_start;
>> -	ppd.vaddr = workarea_start;
>> -	ppd.vaddr_end = workarea_end;
>> -	sme_map_range_decrypted(&ppd);
>> +	ppd->pgd = (pgd_t *)native_read_cr3_pa();
>> +	ppd->paddr = workarea_start;
>> +	ppd->vaddr = workarea_start;
>> +	ppd->vaddr_end = workarea_end;
>> +	sme_map_range_decrypted(ppd);
>>   
>>   	/* Flush the TLB - no globals so cr3 is enough */
>>   	native_write_cr3(__native_read_cr3());
>> @@ -379,9 +402,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>>   	 * then be populated with new PUDs and PMDs as the encrypted and
>>   	 * decrypted kernel mappings are created.
>>   	 */
>> -	ppd.pgd = ppd.pgtable_area;
>> -	memset(ppd.pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
>> -	ppd.pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
>> +	ppd->pgd = ppd->pgtable_area;
>> +	memset(ppd->pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
>> +	ppd->pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
>>   
>>   	/*
>>   	 * A different PGD index/entry must be used to get different
>> @@ -399,75 +422,158 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>>   	decrypted_base <<= PGDIR_SHIFT;
>>   
>>   	/* Add encrypted kernel (identity) mappings */
>> -	ppd.paddr = kernel_start;
>> -	ppd.vaddr = kernel_start;
>> -	ppd.vaddr_end = kernel_end;
>> -	sme_map_range_encrypted(&ppd);
>> +	ppd->paddr = kernel_start;
>> +	ppd->vaddr = kernel_start;
>> +	ppd->vaddr_end = kernel_end;
>> +	sme_map_range_encrypted(ppd);
>>   
>>   	/* Add decrypted, write-protected kernel (non-identity) mappings */
>> -	ppd.paddr = kernel_start;
>> -	ppd.vaddr = kernel_start + decrypted_base;
>> -	ppd.vaddr_end = kernel_end + decrypted_base;
>> -	sme_map_range_decrypted_wp(&ppd);
>> +	ppd->paddr = kernel_start;
>> +	ppd->vaddr = kernel_start + decrypted_base;
>> +	ppd->vaddr_end = kernel_end + decrypted_base;
>> +	sme_map_range_decrypted_wp(ppd);
>>   
>>   	if (initrd_len) {
>>   		/* Add encrypted initrd (identity) mappings */
>> -		ppd.paddr = initrd_start;
>> -		ppd.vaddr = initrd_start;
>> -		ppd.vaddr_end = initrd_end;
>> -		sme_map_range_encrypted(&ppd);
>> +		ppd->paddr = initrd_start;
>> +		ppd->vaddr = initrd_start;
>> +		ppd->vaddr_end = initrd_end;
>> +		sme_map_range_encrypted(ppd);
>>   		/*
>>   		 * Add decrypted, write-protected initrd (non-identity) mappings
>>   		 */
>> -		ppd.paddr = initrd_start;
>> -		ppd.vaddr = initrd_start + decrypted_base;
>> -		ppd.vaddr_end = initrd_end + decrypted_base;
>> -		sme_map_range_decrypted_wp(&ppd);
>> +		ppd->paddr = initrd_start;
>> +		ppd->vaddr = initrd_start + decrypted_base;
>> +		ppd->vaddr_end = initrd_end + decrypted_base;
>> +		sme_map_range_decrypted_wp(ppd);
>>   	}
>>   
>> -	/* Add decrypted workarea mappings to both kernel mappings */
>> -	ppd.paddr = workarea_start;
>> -	ppd.vaddr = workarea_start;
>> -	ppd.vaddr_end = workarea_end;
>> -	sme_map_range_decrypted(&ppd);
>> +	/*
>> +	 * When SEV is active, kernel is already encrypted hence mapping
>> +	 * the initial workarea_start as encrypted. When SME is active,
>> +	 * the kernel is not encrypted hence add a decrypted workarea
>> +	 * mappings to both kernel mappings
>> +	 */
>> +	ppd->paddr = workarea_start;
>> +	ppd->vaddr = workarea_start;
>> +	ppd->vaddr_end = workarea_end;
>> +	if (sev_active())
>> +		sme_map_range_encrypted(ppd);
>> +	else
>> +		sme_map_range_decrypted(ppd);
>> +
>> +	ppd->paddr = workarea_start;
>> +	ppd->vaddr = workarea_start + decrypted_base;
>> +	ppd->vaddr_end = workarea_end + decrypted_base;
>> +	sme_map_range_decrypted(ppd);
> 
> I think this needs to do the same sev_active() check as above.  It might
> be working only because of the inherent instruction fetch decryption,
> but it would probably be best in case anything changes in this routine
> in the future.
> 


In SEV instruction fetches are always decrypted hence I didn't do it.
But I will follow your advice and just to be consistence with SME I
will map this as encrypted.



>>   
>> -	ppd.paddr = workarea_start;
>> -	ppd.vaddr = workarea_start + decrypted_base;
>> -	ppd.vaddr_end = workarea_end + decrypted_base;
>> -	sme_map_range_decrypted(&ppd);
>> +	wa->kernel_start = kernel_start;
>> +	wa->kernel_end = kernel_end;
>> +	wa->kernel_len = kernel_len;
>>   
>> -	/* Perform the encryption */
>> -	sme_encrypt_execute(kernel_start, kernel_start + decrypted_base,
>> -			    kernel_len, workarea_start, (unsigned long)ppd.pgd);
>> +	wa->initrd_start = initrd_start;
>> +	wa->initrd_end = initrd_end;
>> +	wa->initrd_len = initrd_len;
>>   
>> -	if (initrd_len)
>> -		sme_encrypt_execute(initrd_start, initrd_start + decrypted_base,
>> -				    initrd_len, workarea_start,
>> -				    (unsigned long)ppd.pgd);
>> +	wa->workarea_start = workarea_start;
>> +	wa->workarea_end = workarea_end;
>> +	wa->workarea_len = workarea_len;
>>   
>> +	wa->decrypted_base = decrypted_base;
>> +}
>> +
>> +static void __init remove_workarea_map(struct sme_workarea_data *wa,
>> +				       struct sme_populate_pgd_data *ppd)
>> +{
>>   	/*
>>   	 * At this point we are running encrypted.  Remove the mappings for
>>   	 * the decrypted areas - all that is needed for this is to remove
>>   	 * the PGD entry/entries.
>>   	 */
>> -	ppd.vaddr = kernel_start + decrypted_base;
>> -	ppd.vaddr_end = kernel_end + decrypted_base;
>> -	sme_clear_pgd(&ppd);
>> -
>> -	if (initrd_len) {
>> -		ppd.vaddr = initrd_start + decrypted_base;
>> -		ppd.vaddr_end = initrd_end + decrypted_base;
>> -		sme_clear_pgd(&ppd);
>> +	ppd->vaddr = wa->kernel_start + wa->decrypted_base;
>> +	ppd->vaddr_end = wa->kernel_end + wa->decrypted_base;
>> +	sme_clear_pgd(ppd);
>> +
>> +	if (wa->initrd_len) {
>> +		ppd->vaddr = wa->initrd_start + wa->decrypted_base;
>> +		ppd->vaddr_end = wa->initrd_end + wa->decrypted_base;
>> +		sme_clear_pgd(ppd);
>>   	}
>>   
>> -	ppd.vaddr = workarea_start + decrypted_base;
>> -	ppd.vaddr_end = workarea_end + decrypted_base;
>> -	sme_clear_pgd(&ppd);
>> +	ppd->vaddr = wa->workarea_start + wa->decrypted_base;
>> +	ppd->vaddr_end = wa->workarea_end + wa->decrypted_base;
>> +	sme_clear_pgd(ppd);
>>   
>>   	/* Flush the TLB - no globals so cr3 is enough */
>>   	native_write_cr3(__native_read_cr3());
>>   }
>>   
>> +static void __init decrypt_data_decrypted_section(struct sme_workarea_data *wa,
>> +						  struct sme_populate_pgd_data *ppd)
>> +{
>> +	unsigned long decrypted_start, decrypted_end, decrypted_len;
>> +
>> +	/* Physical addresses of decrypted data section */
>> +	decrypted_start = __pa_symbol(__start_data_decrypted);
>> +	decrypted_end = __pa_symbol(__end_data_decrypted);
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
>> +	sme_encrypt_execute(decrypted_start + wa->decrypted_base,
>> +			    decrypted_start,
>> +			    decrypted_len, wa->workarea_start,
>> +			    (unsigned long)ppd->pgd);
> 
> This doesn't seem correct.  The first argument should be the dest,
> not the source.  I think this is working because the mappings aren't
> actually being updated (see sme_populate_pgd() where the page table
> entry isn't updated if it exists).
> 


Ah I see, I was under assumption that sme_populate_pgd will update
the flags (if they already exist). I will take a look.


> There probably isn't any reason to check if the entry exists, so
> you should be able to update sme_populate_pgd() to set the page
> table entry no matter what.
> 
