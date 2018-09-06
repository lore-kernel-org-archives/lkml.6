Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEB1C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C822075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i8h4wN9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C822075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeIGA1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:27:25 -0400
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:45688
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727731AbeIGA1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwmNz/ilfeXI/g0b5jHTYePT5yQ/AMmjDycHDU5vQL4=;
 b=i8h4wN9Xz5O10YtfSgd3JsZRBIfTXyz5QeYEXhAqwLpk9kuw/24xtzIIk9fFk+JLbK+y5rWfYQBFoqZMZMjw8KhduKTt5UuHnH87wcIKD27d86Wfn5GtT2JdSs4DBi/ugDvQs85Y06YusbgDKk45jCX4slk9pmKHRGaWHiVDcHQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Thu, 6 Sep 2018 19:46:29 +0000
Cc:     brijesh.singh@amd.com, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Sean Christopherson <sean.j.christopherson@intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic> <20180906135041.GB32336@linux.intel.com>
 <20180906141825.GB370@linux.intel.com>
 <fcd5efe9-3e26-3aff-9173-9f8c3f3183f1@amd.com>
 <20180906184750.GB4570@linux.intel.com>
 <c219ec47-1a1f-5d19-0b5b-0cebb706ca6c@amd.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4ad34789-93b5-509e-fca3-1e00061c6770@amd.com>
Date:   Thu, 6 Sep 2018 14:46:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c219ec47-1a1f-5d19-0b5b-0cebb706ca6c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN1PR12CA0076.namprd12.prod.outlook.com
 (2603:10b6:802:20::47) To DM6PR12MB2684.namprd12.prod.outlook.com
 (2603:10b6:5:4a::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24df0407-9a1c-4510-40dc-08d614317112
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;3:266+CIO/Ug/44hb5MTzrZIUQ5t/Gruc1edzU4+APwcPpSs9VhpmpN0AORPF42DmVQgdj1K4ls/VaDq5H/vKF7HwDskbzQBKthE0VcBWUlD7yAW9PSelbqq90V8BzyyiWutUaP4LaGTJDFd+aGMacBt1XLzI72+H59ZeQQUgPal9g2a0lHuAp21OcnQ5Ik7SlVp1CwwGvgN48p68CCsdaIGVwThRTPOHOgToqfAFHo9o+PI/ksFhJUilL1Q/GYkzn;25:bZl79Ap5WLE4zor937sMDMBmvoQcRD4/jIdWiGlSx48KG+9Knl8I6Z/T2LVWPvAFCa/5d3qImRwhJLwn79KiZ0Gpqamym/yJbA8Y4CS864BL0GrDkUi5CnZdQKcgHxOH79AxfWvRXztrlMwI1ig4MLp8vidQzdeh+PQpjYRPFzs5t7fGecwo3Q9I5hZOA1TUQqUV0mifOM3/whjK8bmBjp4wCCDh7ncQEYihoz2mTvVbXjxk7W267XQ0sJU74mMy/BbU82656qAqs4OTVQ9dVm+NcmYPLjtNiUb2YWlLCCphEK1TiuvpI2ZTO5H0StpSbVn766aBxdbyRXOkq+G5Ew==;31:i9ijJMrAu0RCeUWxLhCCvKEIr/zUq/HC5yGkjCB6Ecmw9MszfJJzi1SY7qse1jRjZ3sWT546rrTY0iBsRcql1uX1MBbxUbkOD1HJ+hAcpq7ya1mxkHIvhLUnovTqiu1m/seraqJOnAr5tVzsmAJj5k0t1ip6Btnsg7VQ0cmHbUGa4aNiZP/hs+23X5NtQXXcDJ4Rac7oHBT+3wYUx2vvfuOV/d7T6uWpl1hyEzo5OnM=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2684:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:seYtnN4as0feOjqPSgv7tAN5kOxhZQieVdO6KMi2hrkum1xoq+xh3S6i2Cinm8MFyA+ezqRlMT1dZEliXfSprKmSUC1RfWDZxLmQKVKrNPX+19qjkwYNQxUe4rvM9O1jQXu7tXeSgdc75yPicCPXH/I2dTwN8YFdAlenMO+Ksn7Mb5CrHSpSMEe/IIUg+Im694T81gtOwPN/0Mygjno1lbZHMuG36Nix42HYaNdDKVDv6gCQU2wzv96mx6zfRGGGFHoH/KL5oV7sfKX6hPlTYB0ulfVEvkd8y40MCK8oCmYoIWYdzX0sGBv+q0l30dRnQ3ADFgzpDWLtvlt4ZE9GaaIEPF+ZjkNWxYKbTCaJ/G7ZQn3Gtg8NQ4DAz4DfuBqiUxZFF/T5zUv8+CJlesgXbMiBT0NfeeDGBZFONlgkFkq4RGD3sVnZjxVPFH8j/tlr6BcDgvWRbTxWneWDWGdYtdSsoC98PBuR/nnQZURltRq4oXSMQrU3flxOGLYvxE/m;4:8teX5n2j11et2vFwPpDMxDcQhtBAFX/CVC7JFSk4K/ddCvZoyPWz61b92NXkS7P+P0ALvOV4UKQ3QhSauCNkCrd8XGeZAegcVMQH1GB6jbc2IkytGv4Xh8z4rQ+5O+gKp8eE92ZNZY6b3MY0PHTrCOqvPbswE9/H0LQyQxNuFnSnhQvHJNg16jx0PPyLmJWsD0NPX5U+vO7zqud7dC+RoXqyqTLjXv9rQIFptOBRxjf/ZuscuqESS04fKR0oNSDf0Dg92Hf0Ae883H5SaLXfUg==
X-Microsoft-Antispam-PRVS: <DM6PR12MB26840BE1B775D8AA6FDC840AE5010@DM6PR12MB2684.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:DM6PR12MB2684;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2684;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(105586002)(6916009)(6666003)(86362001)(305945005)(31696002)(23676004)(52146003)(2486003)(31686004)(76176011)(7736002)(52116002)(68736007)(50466002)(65826007)(4326008)(478600001)(106356001)(2870700001)(5660300001)(81166006)(81156014)(25786009)(2906002)(53936002)(6486002)(67846002)(186003)(44832011)(486006)(229853002)(476003)(2616005)(8936002)(446003)(956004)(3846002)(6116002)(11346002)(77096007)(64126003)(97736004)(54906003)(36756003)(93886005)(6246003)(58126008)(16576012)(16526019)(53546011)(47776003)(65956001)(65806001)(66066001)(316002)(386003)(26005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2684;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjg0OzIzOmV6OUZrQjIyVi9LUlIyeTZIZGNwVDIwbVBl?=
 =?utf-8?B?N0M4NU83SEZIKyt2eEp1T1hzSkVVN3JZejhJWVNyaGJHcitQd0Q4WU1DQU0x?=
 =?utf-8?B?MnE0MHo5WDdmamRQeHRNcGNpR3hrcHVFOEZLa2tqVGdQUFp3TkFDZHppNWJG?=
 =?utf-8?B?bHJNUUxiMFhkQU5tWXlYay9NdTk0QzNGd3VpYzBlSTQwalRnT1FBd3pneVEw?=
 =?utf-8?B?UEFWZlcyaUhkNHFRWmVUcEZIMHhjMEEwdEpwcmRrWVhXeEx2Qy95V1ZyaVQw?=
 =?utf-8?B?UGt5UThaa1J0STBaMDVUU096d1ExY0JKcnNTSTNmTHUzTmI0YWFYM01iY3Js?=
 =?utf-8?B?YzBsUnJLc2hnSTRKVlJLM01iZ2NIMTdoVmNma2FsdFVnanFZSFI1b003TGtR?=
 =?utf-8?B?eUVSSlV2NXJYK3Z0OXJQQUtMYXdXU3NhTFdHOGVzUnA1NUtEWTlKbGNMdzJm?=
 =?utf-8?B?UDJlaWJydjQyd0hZT3E5OGZvNHMwRHZzTnRrWU95ODd4ZlhlR1N6cXYzb0Y2?=
 =?utf-8?B?ZVFlc2FxUU9yaHJ6amtEUDFkV0lXZHVueHBNa3ZjQjRpUzRUcE5wUU1XeDhh?=
 =?utf-8?B?QjErNFd4cFlsbUVzTjBEOFpvd3RNZnQrVStWL3cxYjF4YjdRbnNjN3ZTTktJ?=
 =?utf-8?B?eFhmNDBzaWw1M1M3RzU1OXZkVzBMVFdsNS93ZzFXL2duZXlQMk9vb3AwcGo5?=
 =?utf-8?B?ZjR0Y0pRdjYxVjJYelRudjh6RmVyMWtBL0JNVXdpbllUejdOV1A3SXp4eDMx?=
 =?utf-8?B?SGJYRGFtaGxxRFhyNlhtd1BaaGViZG9WUjlUK2Q5OUo1bWNsaXRmUUJ3cytN?=
 =?utf-8?B?MjM0ZWF5eFd4NG12V05lZVNaVytMcjBRazNhQmJXd3prYzlMd2tZMUF6MU9p?=
 =?utf-8?B?NnhqS2dDOGFxZ3hQTGs5UHBDZUFwOE1vNzNkVVRRRHRHQmZrcytscjRUdUc1?=
 =?utf-8?B?S1JzeTM4RTdhajJ4MXVVQU4wUlB4aWlIRlE5NDBCSk5DMzZTbkg1ZDloZ1A3?=
 =?utf-8?B?MVJueFU0bzdpenRqYWtzNXZHWjVZRzFaMEdhbm9XV3pFVlQ5SzloY1pyOVZ3?=
 =?utf-8?B?RTh3UWwrN0RrNnZnNm1HQnIxZ3I5UkpMVTVkL25DSVdyVTF2d0tUWENYcTJY?=
 =?utf-8?B?aTBndVlubzVVOG5oSkJvUlBqVHpMUENWQWoyY0c4cVZFZTcwTDA0M016dThQ?=
 =?utf-8?B?ZGduUFprcVA0dk42c3FwZFdUaWpEbmEyaDVteGlDQ1VJM1llOWpiejJ5UUtS?=
 =?utf-8?B?aW1DWnJvak1mSS83TC9TY0Q1NEVZWDVoUWNCWlRJSTZvRHhXZm56bm9Pa1JJ?=
 =?utf-8?B?MTNKMjlka000MDYvRU91bzU2dmlDMElpZkZRclBvWC9VQ0h0eEJucVZuQzdx?=
 =?utf-8?B?cFppWHJPZUtsQ2dyRDBqWk1sdDlVMlN0dVk0b09SQzQ3UUVsUjhSbDErNitX?=
 =?utf-8?B?aER3SlJKUktJL0E5cEk1TFVaUlhLUkFocmZ5U0dJcUhVMXZFa1VhNTdFVlhO?=
 =?utf-8?B?ZXBEeGZ4dk9ycmVVNE81Z0s3TytETi9UWXl0NmtpVC9nK1ltRUQ3ckV2K3Ix?=
 =?utf-8?B?dy95U1F4U2luUFN5b0w2TjkyVUNqaE5odllGVUxxelp0ckwxdzM5bndkMFRi?=
 =?utf-8?B?d1VZRHREb1c2R1AySWtPNS8zdmdpc09hbFVaVDc1bEFVclpWWk1pRG5ndUk1?=
 =?utf-8?B?R1dwdU5XVmt2NlZ3eUJYWURXVnlSRWtTYndkellSNENoV00zOXZTVDZzeXNZ?=
 =?utf-8?B?anlSaWMwK0lCaEtJV2MxSWpiMU0zV3FCUktBeDJ5YisxeDY5cjlRUXFzMGxi?=
 =?utf-8?B?ZG1FdWNZYXozOTcwMnBlajFhY0VYc2ZVZE1YNTV3N29yZVpXZUpqMkNvRktG?=
 =?utf-8?B?eHlyaVZkSmpXNjJZQllvNnZjRlVDZEJnN0wzU1ZCSThVOXdSTXk2dEZTZ29j?=
 =?utf-8?B?S3ZhVTdneTVMYVpFN2pDU3J5Sytoay9sSnF0THZ6eVBteGhFajNBSFR4aEJQ?=
 =?utf-8?B?MDQ0Y1hCdFUxV2JzT1A1V05id3QrR0NGWlp6UT09?=
X-Microsoft-Antispam-Message-Info: uL9W+aXT2BjWvTlhN+74/7RlhLNMhpf1lig8goJevxDY4/+4ldrH/r8j3hx6xq7ujd2z94gJeNFRn71rI47gqxUsohHY1nc5VfHuqwYp8kNTwwhvMyngDCT6143KmbIf7E0RPERcx9vvvhaHNsRrF+xTR/0XPsZSlDfl721ze7sdLknWGrY9NpdMt5JsDvMIBCd/zbuqYxXOdWDO15J0005tgtNSfrULoMJn3Rt36btgxIfv4wFDjPS6QuRh3IlxyPiw764bCm3vqij1NoVdUQnswYTKw8ipDCUqRc72Juu+WNHpWpsOmZQgzWBBlbBWvXIyvbVgunuYKsU66tTSE0y7mOUyfrPePEZ2uESWu6k=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;6:VFqOayQ7et4oEH8lyebtqbdrIlo49TKCizy3ZUex7eEXfDk47qVvCAm2tz3r/llXolrlGVoppCWpLa5TegIV6T9NV6cfhIKRqCp72Q5iO0k88aFSC2LjnES4G3HOnoTfJoOYfxpTdqA7JdJdE3DsNr6r7A6CeVsVi1fQHECWOiR5gTsHVhxFzo2HGJU7msvPZmeMF7B7YY0cr6sqiBP89dAOCY3b52NyfO1X1cd35V9HeM/b4FHsZymvI2DrLzXoUa1huoeCXLcBNPRMe/D2/m8ehs8fz+X1RNWi2cbQcTdYXNLIGl++PV7phqTxecFIsjQE3wxWXtPQJM5CEsBElvehubF2jL+4IRi3yVy2Nw4y7DVbDHutbpjamtMbWJr1mQ6LxYWRHNTUFpJuyruESb6QoddFidKl1Rr6WvA8u9oe5p+q63LnK9xu+gWQBbFI8dCWU59UcY4ZFT8FkiM7Dg==;5:uVTISEZE17nQSEGw4lK8VXxJboUGTvb/IPrZibssJ/mKI2wbD67OJ8Akt5Bpo50cQVHghzLnh+zs1FHZ+LORIYTQXGrNEZ8P9J3qa3fziTSVQ+Drt/jMCdtduYwToPkgA0BUK8yEhD5GlcCUxsKijBxFVnp/SKLr3VMRXSdVaCE=;7:hZUqd7gstLhQLxnJl5QOtk2vLgemTCl3ispYySziJLvSnlb2BmqyCOf6cr+q2FiVyT6HcOxZs7MGbw1rQ9fsF0kMx36xi6jSq8miDqhLxvSH7CkxkWkqf7rFaus6CVnNmnINkgavtBolYuYUAQkaWvtm6Me7aI3crP1X0+HYJ+K37lgW0VuMH2n/xS2XCZn4mT2jUmfHCk+VWiEsJQX13fNa8IDt+LKCjxai/3KK3ErNBSA+B5wDI5TXEDvMVScl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:fivoauEjUIxftbuUDzf7vP6G0/IsBj3bhY0qK7ycY/alBEoUWdYIjLK0p3bP2lxMYw3IuRam37uw2T/D0uo2PqT15inXBL8udWyiZU1kyRO70SFL8SIFtmVo2xICs71F0T0NeNn0xqy/jVbjBI7rYCzvdHoUiKLHLI8zBbSLoE7u5WwC0gJlOwA8bfUx+MGgkQ2UKQ6E9+IKbmuj1DJ6m3mISWmd6wOW4xmtYu+EK+5mAk3cn5Qe+j7bAHcIDxkC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 19:46:29.5603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24df0407-9a1c-4510-40dc-08d614317112
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 02:24 PM, Brijesh Singh wrote:

...

>>>
>>> Again we have to consider the bare metal scenario while doing this. The
>>> aux array you proposed will be added in decrypted section only when
>>> CONFIG_AMD_MEM_ENCRYPT=y.  If CONFIG_AMD_MEM_ENCRYPT=n then nothng
>>> gets put in .data.decrypted section. At the runtime, if memory
>>> encryption is active then .data.decrypted_hvclock will contains useful
>>> data.
>>>
>>> The __decrypted attribute in "" when CONFIG_AMD_MEM_ENCRYPT=n.
>>
>> Right, but won't the data get dumped into the regular .bss in that
>> case, i.e. needs to be freed?
>>
> 
> 
> Yes, the auxiliary array will dumped into the regular .bss when
> CONFIG_AMD_MEM_ENCRYPT=n. Typically it will be few k, I am not
> sure if its worth complicating the code to save those extra memory.
> Most of the distro's have CONFIG_AMD_MEM_ENCRYPT=y anyways.

We can use #ifdef CONFIG_AMD_MEM_ENCRYPT around hv_clock_aux definition
so that it gets defined

Something like this:

#ifdef CONFIG_AMD_MEM_ENCRYPT
/* The auxilary array will be used when SEV is active */
#define HVC_AUX_ARRAY_SIZE \
         PAGE_ALIGN((NR_CPUS - HVC_BOOT_ARRAY_SIZE) * \
                 sizeof(struct pvclock_vsyscall_time_info))
static struct pvclock_vsyscall_time_info
                         hv_clock_aux[HVC_AUX_ARRAY_SIZE] __decrypted_aux;
#endif

