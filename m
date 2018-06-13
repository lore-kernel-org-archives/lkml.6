Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 606A9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED68D208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Q+iz3GpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED68D208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934650AbeFMIec (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:34:32 -0400
Received: from mail-sn1nam01on0089.outbound.protection.outlook.com ([104.47.32.89]:64766
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933912AbeFMIe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVT8+IgZZDJYpFNCjyrkG92lDvQ6K0iUIrfqjPc4P+M=;
 b=Q+iz3GpNuV24+Co1QS0LH4NAcRyO+LEIAcjKsAaeNZbHcbYtNE2eY8gi3qBngVCW+JkDb4gxunP6ARyA1b7cxi0tvmbIpKvacyb7OXYqsYnSCl5GrOjOSA3Z0Kn3sdoqkgKoVyVqJDmmrGZOmtFh+piBT/wJGZYjmQlKUiVUFZM=
Received: from localhost.localdomain (155.4.205.56) by
 BN7PR05MB4577.namprd05.prod.outlook.com (2603:10b6:406:f2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Wed, 13 Jun 2018 08:34:20 +0000
Subject: Re: [PATCH 1/2] locking: Implement an algorithm choice for Wound-Wait
 mutexes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20180613074745.14750-1-thellstrom@vmware.com>
 <20180613074745.14750-2-thellstrom@vmware.com>
 <20180613075411.GA17681@kroah.com>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <c4d005b7-4b5a-3d21-79ba-99e24fb68f4f@vmware.com>
Date:   Wed, 13 Jun 2018 10:34:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180613075411.GA17681@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0902CA0025.eurprd09.prod.outlook.com
 (2603:10a6:7:15::14) To BN7PR05MB4577.namprd05.prod.outlook.com
 (2603:10b6:406:f2::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ced9816-2ee8-4742-c471-08d5d108772d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4577;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;3:Vo6S+d48ZhcqJoOpWOzI0jwDyfj8T1cLF2RfjUbFbWmthZXjjh8xz9N23GYYM6tQ1EFf18E1Qe/NahGvy4Y/ZKDCQ2PkhBRgrN0yhSRk8cyeyJwC6+0dcAw0JfCERJVO0mTP2pQ81sX1qoKn5j9+OZ/nqpdC8GsqhPNLVvK3Sd4/c2vqMlmVGb3IHJJCXGnrwBUyLZEkd2eLIlzXc/jP+S8vJ0nkiFVMR9WmGIZM63OLR1d56PDtBR/XiapJVrfJ;25:u9typwfPuuZarDJQFig/hRf0+GUguz9zK+S9GXwJBGilMGT3eL+9bmFcDILfpRt2UiigqOEMEczJJNyJDRbjz1NTXAcmSBtkfMJUWND0FhCUZfq7ZTZvSXYqbje+terZskpCMFixrUlYsKsoZY2jTlv8ySldARMI+lgegM7DlSRFrUkPbht9lwq/wuShjcKZFmYhNAFMPO2/gEHIOcosUyC7ZZuqB+1gRC2y9ZMQ/NZJRFZi3JmY5lZnyFI9DgZCLjlycIfO+9D1898Y+LorXSyccTzL2OyM92oHF5uChOtGvqdRReIDsRMoXk++njcAW6NZ9Ye++ljLMbFSqwDOCw==;31:tF+feDS6Dz2y5plpOiCRVXAhM3iB+Ch6i6Om937HycmrrucEdrIz4DJ/f1ra1nGPHYGPBs40SHhJnfrsn1GbG0aFd2LFmUd2qey2+xBeJ6Mn+IvOYzRRPYlQXu5MVZo8ZxQ7znknDuoA2VeZLydGw3EdqnMgwOyJ37mRpxHCyXd5WOO4KZwu0n7qhHgfkRt92QJa+mShWfXhSTAxwN7kM/fTE58eqNlrAPbbs+RJKpI=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4577:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;20:CU2YfcCevbQ4mJ8hs++IXVGFvaKZqBFQZYJqESqCEe3jjdLYR6gsOl21g61eq2Zypg0aRp/OOYTGD06GqSlrWpwBukzhQ2lsMTamfcHwm/pwDy39/WLX6CWcLLV7tXYU8UFyQkkKJb9Ytq6vbBQto0mn2h3yfV9ETkvXLein5PNRl7NXBB3N21v5acexPEMgUFsRQvnPAUNsKUmVwO14jcv5mNbc3ykIBgXbXp4YjVM4jRbhPzxnxNkcD5iMnWflOcnCFVibi0J+5JD7o8cxM7JBhY+KPRDwRYUPGdPDmYrLEZzNEOr/zTDgYtU8zFaqXFZK+FdiRE0iZhDpvfcBdKDxsWqp2VF8+0VYTQgzjwVvtNCQSgfyg2iFhZYULKFIMy3bN4JwW1rg0Kcf0aV6eraw6hVyvkVkPHf8kFvyEZC+FH866bxLv7WhFrhbmzDMJeFviYDIDFbwSOxGv14BJaFe7bC5eyVZW/r8akPivByxNnjyRBdcQDRgV6ZIHNEw;4:fj8I9yJTNEqq0x5oGYOIkYmggHFrrXLpzEbpkLUkQ/DJWzefa0Qv79oPTGXt7k4S0tnLgPvnOO/NFgRsdXfLUrlQqMJKAsxrZyxU6XxVESF4MVq4UHhlIX22oyL745tLEdKGd9pqgjolZeO3WjZ39zLz0BRubU2oBmAWEEEUD9Q9En8koygD26SpbIHG6Y+mXAmmV6OMP7bJtbL/PzqxoBijHhlHcMHBNiptxToDekNAGcF7PYZPoxtzcSkChrTtB+n7Yu/aL+o5blIP/8YJOA==
X-Microsoft-Antispam-PRVS: <BN7PR05MB457730132C6C801A186BADB0A17E0@BN7PR05MB4577.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4577;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4577;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(396003)(39860400002)(39380400002)(366004)(199004)(189003)(76274002)(6486002)(486006)(23676004)(52116002)(31686004)(52146003)(229853002)(105586002)(2486003)(106356001)(25786009)(47776003)(65806001)(65956001)(66066001)(68736007)(186003)(16526019)(36756003)(26005)(8936002)(76176011)(956004)(316002)(2616005)(86362001)(81156014)(8676002)(446003)(476003)(81166006)(11346002)(53546011)(386003)(6506007)(31696002)(54906003)(67846002)(59450400001)(58126008)(6666003)(2906002)(50466002)(6246003)(6512007)(5660300001)(65826007)(230700001)(6116002)(3846002)(7416002)(6916009)(64126003)(97736004)(7736002)(53936002)(4326008)(478600001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4577;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjA1TUI0NTc3OzIzOnNPM0pRaEl3MmtvU0w5SGNMREdNbG85SmZW?=
 =?utf-8?B?M3FvcWZHOFNlOGZScm40QWUrL25aTGVzSit0cE1nWnhNTlQyZ2JHdHdaMEJY?=
 =?utf-8?B?KzIyNEZHUitRSlpSN04rSTBjWWRpUlcwYnkrMFM0WDhWWGdHTm03bWdwWm1w?=
 =?utf-8?B?dzRzMi9MZkk0ZGs4Ym15TWd2MkFXY2lXWHNwN1BSOEFUZlpTTzFYejRITS9m?=
 =?utf-8?B?T2NIZExpN0srL1JKZlFqdS9wbnI2NGNIY25od3pQSmJuc0lHbE43NVZTUWpY?=
 =?utf-8?B?ZEZ0WXFBZWN2RHJPUlhuWGozYlozMDZQQWg2WG0zRXMvZnE0S29acnZjOVVP?=
 =?utf-8?B?N3RqdTZsd0gyUlBtbUpGSXI2cUcxTkZuUFBMMGp3ajJJbTZCd0pRbVRCUXdJ?=
 =?utf-8?B?bkx4STA4OUcxTTZ6VjZFRDRTRkRsaWZWWlZrWnRUdDRLRjhObktTai82ajFI?=
 =?utf-8?B?Um80UTRZb25TbzUzQzBtcXlaYmg1eWxsVkRWU0RTYkFxd3Y0RU53UHh5ai9i?=
 =?utf-8?B?cWkvU2MvQUVsM3l3dU92WGQxcGU0VmNrVTlHdExJWU5iYU91RTdLMU9iK1la?=
 =?utf-8?B?VkovNnpZTUJsdXRENWhTVXJreUFIQ1ZQQjROZVp2dUlQL0lhaTFwUVRNWVNa?=
 =?utf-8?B?bjIxME5pSWJuMGtMZnM2TGhSSjk2eXNtYUxFMVFjTUFQckNkMFJ1UGt1dUU4?=
 =?utf-8?B?WS9pQ2FUMW5yVk9kSHVZdmxuTTFsYyt2eS8rdjRvR2piVWZVakIvbzRQcXNk?=
 =?utf-8?B?dlVpL05EeHFwVEU3SGVMTG45VnUrcnFLVFNYZnBOVVlONlZnU3d0ZkV4MDVo?=
 =?utf-8?B?ZVJETmFqV3JtWWNTT00zOWg5TWFUaGw4dllYNEZvY0R2NmJBQUVYdU1iVGFV?=
 =?utf-8?B?WFBvdUJBOHJmSmlTSGxLR2RBTXlJbVhhc0MvdDl5Z3l4SzRqcFNuZW5pSXM4?=
 =?utf-8?B?ZVpxeVVxZzFzNEt1ay9KYUF3aTd3YzR5VnU2QlhYZ2NpaFdnMTd1alVIcUVr?=
 =?utf-8?B?ZE1JT0RCb1NIWk9EL1AwY050SXZTVHFCKzdubFVDcU5PQnBjdTZSRVZod1VO?=
 =?utf-8?B?RWg3UmJ4cmJuSUxSbzluNHNrTzdHSG5ReFE2RXlkelhnR29KbncwbjNmRzl1?=
 =?utf-8?B?WDZTcEQ3U28wWEJrM2xwbjNTYUV1VmJCSHI2Z1FUNnF4UlZIVzlQeEozbE9u?=
 =?utf-8?B?SlN5Y0ZmbVMzcVVLUm9FU3Q5YytEQU9Fa3AxV0RYN3hzbXZqY3IzMHVEZVVE?=
 =?utf-8?B?MjJtNjVFa29VME84R3ROWUdvelNJekFxdGtnZGtWYkZwTUlKQmh5VUtnQWpG?=
 =?utf-8?B?SXJGWXhsSk9YaE9tR2VyRkYycDNTalE4ZzZSeVhtT1EzbmdneXlsMFpHS0E4?=
 =?utf-8?B?cUlKZ3NxYWdWUFM1Q01UUWY0VlBiWWowNWlzcFlFdHhXN21ZSFdqVmlHTUcw?=
 =?utf-8?B?cUsxZng5Y1pMTFlsTllIRzFUWXFvMVhEQmhVRXhnV2Z0WGk0ZXJ5TmRkQ0g4?=
 =?utf-8?B?TCtFb21GMmU0QXI2OVAyTU9tMnMrN3hDVGphckk3SERZQlNaaGttWFNseDV2?=
 =?utf-8?B?ejZKK3c3NkpqTDFGSUhOUk14SFN6b3VCR3R0Qm00czZnc2FoM3hIRDE0c3Za?=
 =?utf-8?B?OTh1cXVaYWxrOTBsQWpFVkZnRSs2QW53c2pOT2RKbks3aDh6VTBudVNuS3hG?=
 =?utf-8?B?cW51SXlRV3hTMkVmWmx6OHo4Nk5pVjhuR1NTejNaRXhkTVViYzdqamNBWjVS?=
 =?utf-8?B?M3l0UjM1MTJGMGc5TlFCYVU1UlZOVWxUZEhsQjJnTmtxQ3lHeFU5Y011MEMw?=
 =?utf-8?B?YXA4dkZPRnpWZnNpYURtZThFaCtiNkxRWUlHeTlwaXcrM3RmMWM3aTZLbk4w?=
 =?utf-8?B?WHYrYlpURnRLMFpVYmJLM3ZicU41akNQVGVRL2hScmxZTUhWV0RQTHh3SWsr?=
 =?utf-8?B?MDVKd0dWdi9lWWEzVTRNRFgyM2ZGOHNuRDBzNFg3cXVMZ3YzcDlLeHV6YmNu?=
 =?utf-8?B?dW1kenNxMmRsR2lBcDN1ZFhFK1NtY1FaOU5SRE5INlRMN2tmQXA4U2U2aDdT?=
 =?utf-8?Q?VE+el9JAkr6QwCgLqjPnrbg85?=
X-Microsoft-Antispam-Message-Info: PMxYwQDOYOy81D1VwBh4opxygQBrw/vfrFUVsW1JOyPqkenPHuN1gbV4cNi5xBBq9/X5rOXlvOBsrvtsWYs2jp1hUGviO+/2zKpa9S6nib9U2OWELlRly/dnT+6EtlTx1BabFJmG7ofA2hVQdsDQZ19Q8DuLZbA3byWFsW34naieAblbpoH/1IPN0CVl9WYk
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;6:436AxuBU77LU9jhzX7l8Bw/R48LeY2YjMtz84ZQ6ekP9v7xh1oyrDZkj7hPqM+hdQJMoW9Q5XRB/y0O11zkyLfEOxQv+bYeTekWAKxER6uUf3fpORFeIGd5cL7ZlL+03003MTc9GyqhBDcDec2t7FPzN3LbXpLXxugCIRra2RJN6FlKK/+Nf2O2Caq/n0lPBsTuWNL0qd+Wu2xaE+frTTLtK7XvHrCxHegmwJBdqE8AZpRSSAFj9TX3rC6a+7KnYxuFdzI4kjfoITBQNcTRdR9QiJ+ZI2uBwcBMq0WDifMbIrfcf6dMEQOG8por7n/9DjCT8XkwcZMjhmPT5Uhm/r/svsI8JagiDPwzcTj85wepxKrtJx4sWHnBRSl1HyirY9Z8Wj1oR6MId7oHksZPiBycc1a6SjEfMxvz+XbkDFbCVTTxMIP2QgeiMev6Qbr+59NknVfTgAjBQXyRF5SpclQ==;5:7lf64hB9zU1Or9M+N13Kck+Vzs681pbDrrYyV2esgPMzWEFNxZ4kYbrQqiH026YEfZLf33Mwog/beBtV+iRkH/W5i7xtXQolb5PFsOt5Wh4M/3UOBHa7dC7D+naX5RCZGKm314ZHo4T6uK2fobCHnew8teOgl9JJdDyM/JfyYYY=;24:SScHhqS1TnJcB9A1hUPWjnwxo/iRYnLZw+5tlcSGBO5qJjBJnfNWErbiIFWixPGvshcgpspWhLYfFgqSNbXcwg4ifZMg3IzDz8apm7pNeq4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;7:g6x3k+0AUVmTskfmnpkPZqxYnCYGBkbiMlZ+96xa6yrfS+zHm/dzPYA2F5S/81Chd1tF1NysLSLmKBs+qb/Pa+TvmPwxmG5NGzYjRF3mGZZ2xT9iJ1ZcIDOT6tdi407MTqT9IJvcLAM5PMh1iuMTEyjRmN2MDWAH/zCGcp4Xrpw6tuBihz8rqdPtO+6kl0adt+dzvwNU/E8+KAQ8QEOOHtuivAp/wKj6WMwTM9mlqLJwcP0BJ/eRXlrdEOSP77kG;20:MDu754278HhbaFSgKW0MtfVwD03VCDUJR9IuIU9XOyq0KDy60KcIKlS0UXu7cpG7fJWLh5zLycwL0znTKT3pdq7aEtrp9xHw6PzIn8orI87ET6fiKis5vikNJPGGmTDVk44KEOZAIzbDiz88dZ9v/2DyBX5fOpKgscR+7IVJMhQ=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 08:34:20.1599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ced9816-2ee8-4742-c471-08d5d108772d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 09:54 AM, Greg Kroah-Hartman wrote:
> On Wed, Jun 13, 2018 at 09:47:44AM +0200, Thomas Hellstrom wrote:
>>   -----
>>   
>> +The algorithm (Wait-Die vs Wound-Wait) is chosen using the _is_wait_die
>> +argument to DEFINE_WW_CLASS(). As a rough rule of thumb, use Wound-Wait iff you
>> +typically expect the number of simultaneous competing transactions to be small,
>> +and the rollback cost can be substantial.
>> +
>>   Three different ways to acquire locks within the same w/w class. Common
>>   definitions for methods #1 and #2:
>>   
>> -static DEFINE_WW_CLASS(ww_class);
>> +static DEFINE_WW_CLASS(ww_class, false);
> Minor nit on the api here.  Having a "flag" is a royal pain.  You have
> to go and look up exactly what that "true/false" means every time you
> run across it in code to figure out what it means.  Don't do that if at
> all possible.
>
> Make a new api:
> 	DEFINE_WW_CLASS_DIE(ww_class);
> instead that then wraps that boolean internally to switch between the
> different types.  That way the api is "self-documenting" and we all know
> what is going on without having to dig through a header file.
>
> thanks,
>
> greg k-h

Good point. I'll update in a v2.

Thanks,

Thomas


