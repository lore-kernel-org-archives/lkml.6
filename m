Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3587C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5352220870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dtqGJQSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5352220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeIJSJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:09:50 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:61312
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727799AbeIJSJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sssQNW2ndHn+z0K361ha3JWfGFvZPuvgF4gE45DWfQ=;
 b=dtqGJQSQ4HngjoK12SLMN5pkmz1mWoDvOq51rK5CPpOoiZ/jRooH+n693R7ORLd5+uMPPdQc97URGY2PpWt8KFghB6qaLz4R+ca0Eyx0dONZeYiwRIh4HNN48z4c3F50TerdUfWJuklys1tZ5LYWkO+x3V8jNZZL7C6F+fX42/I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Mon, 10 Sep 2018 13:15:41 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Borislav Petkov <bp@suse.de>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
 <20180910122727.GE21815@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <026d5ca5-7b77-de6c-477e-ff39f0291ac0@amd.com>
Date:   Mon, 10 Sep 2018 08:15:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910122727.GE21815@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN4PR0401CA0004.namprd04.prod.outlook.com
 (2603:10b6:803:21::14) To DM6PR12MB2684.namprd12.prod.outlook.com
 (2603:10b6:5:4a::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0faedee-4e2e-48db-b90d-08d6171f82ae
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;3:DwRz1/5Rb8g3bvWV22g5BmrVxarzYhczJPs/uDd3JNEtmr4KDSvd4PsozFMkabnFZ+jYaVaKy8T1lXTECb4XH6PKrs6kuU+u8CsNB4ucp5D6CgT26dbj3iDolFx/dk3QmfrbyYnUDHVZeQs7QZSFkFqqvuAX/wdqdhgwSRwGg0t3Wc0z/WvgQo3a4WO81EZPJ8W1MFkpplV1KMdof+XqqpRmQMsr3CRzMGpQWRUJ1Zshbmwb8vxBeYS2gP1TOC1p;25:DPABHuZ5sflGyaK6TsG+fy5cLlAjqK+f1GrkISECisVw2lU0LupF/PO5VOZjMT1LxQw20Kpx5UCRcrDYtgIVwJjTmtKdoybMRsZpQAyQzYggzINHNsxWGBZUp7klgcVFlh4dpRO3dwMgLEj/9D1kioiatbCV3NzY5uSF6jR5N4pIJTf8F2ZynbOjohwnza34a3fwz2TH3+2ulgbCfmjrz8+pbE9lAE44i2nEQOr4QjGJv8IRlnFGh2KpalkcqFsf/ElyOT/gqhVLGvfIJ1qAOzOTTmtucM0imyybvaQmFlvVgBaLeGcUpqAy+aIm6UO3VxNOkBrEyof9tZuxAEQWdg==;31:TlUXdGSUIIlIOh14jvA22k4mNYmR2NlZ1DXffHReZw4pQ+KTz5uLCZz0tgnQtK46IPG/v+ZI4lEnXOiDSz9CNKT+6miGSU9S1IxCUod+q8ELXaxan6dvmYHy68y/tuBPHcB4JOP/zbALImc21Pp8ZEXrjiuloaiJGolmzH1k+sos2bPULfIr/+0Qeu8HNDePk2rV5dirj2yfX5b7GWlTgSG91usJt17uxXP8nYHzD/Q=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2684:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:eoMf5T2IERX4JXZikaSlK+cECT9StZrxAgaYoNyUy87Kxh9pk99OKvvxC7X56hwNofr6W0RCRi3Ve1cqvNYOEDHgf1dcNgZ3C5D43RS0If+XEV0l1G9T5t80VAs7xGCJ8odp2zlN4YcFdgS43ncpOjF7bSTGpTq+IILEbonSz5XjrYWicKimMQqmcQ7/lRytUfOg67SzKEpQlGINlYTn0ZGvxburEKDkkSUbgUvEJoY+pBBVcjDolq3ckBJbEKrwW0cutdq5KO8mTCUmWah7ABZ+pT0pqLbJrsirMljWa6qzlxbYySuzj7Iu5hqRfLitDvwZnbbBN0Ni9b+uh5usKgITBHJVnfLLyS7oy/U7dNFMh2AcY9lz1tRZfnfHKPLtIP8CGXjn/7j+Rc5X/xBEc6y/vVHCxCt8dYq/zd21V5Rz+fYuPSkFtzPp/cV4YK0eAKbCNH58EPpg0xkAGpA3g/kPOiT/Oe1w19L4RndLPrUp0ZJ74Pu1kLQTjWhTaPy2;4:11hZxbENdPGCoBELQeF1PzKNpMADs0sQhz0BQOh7Ult09dTm48onWCrTAoXsKNB0Z7uqxSyIffQcMQ/WZF3m2A788ZvOXi23mI+P3zKjVpOfQxEIKwn2rnu86oKdVozVH9Cakm+fYDZvlXumk2a7rx3FrePMgXCKfHNgmK2m26Peg/ax5P8XSetaOioeoVVte5Q52vwGLoTSbM/4HGLa+kBHKrZ6dJxjAgHF7M6jF7CRQO3KIf2aeil2Fk2M67Utj54ZdgFq00dDc8KPTpiOolevj5TrLE4WpgC4otA7iVbbDpdgf+w7MPvgG12KnIDmf3115d/QJHjH060URzsTne6jUImivEhq515TvmvwrHTsQo2pakx2VUwHNTwvhgFA
X-Microsoft-Antispam-PRVS: <DM6PR12MB268420D9A885D19B5F93F48EE5050@DM6PR12MB2684.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:DM6PR12MB2684;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2684;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(81166006)(6116002)(3846002)(8936002)(2870700001)(105586002)(186003)(81156014)(36756003)(4326008)(6246003)(31696002)(31686004)(86362001)(26005)(106356001)(16526019)(25786009)(44832011)(68736007)(97736004)(66066001)(6506007)(386003)(6486002)(229853002)(2906002)(7736002)(76176011)(58126008)(6512007)(11346002)(53546011)(54906003)(64126003)(446003)(2616005)(486006)(5660300001)(476003)(956004)(6916009)(53936002)(478600001)(65826007)(52146003)(2486003)(23676004)(8676002)(6666003)(52116002)(305945005)(50466002)(47776003)(65806001)(316002)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2684;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjg0OzIzOkVIZlY0TVBIaVhTeXpBRzl2aWJ6QmNlajRz?=
 =?utf-8?B?NGY0Uk1uNm9sbUo4cVlhNzhOYnZpbVpodHR2YUhoWWRhWU5rRkVvRkl6NjFR?=
 =?utf-8?B?Y3pOVU5RRzBybW12ZnFBNEd4Z3R1YlMwVDlNeHFQVk5vQVlCaEZMS0kxejAr?=
 =?utf-8?B?L2hQSkY0SDArZjJLbDZrYWNucHlSU0dOOFlSMXA3Q3dCdFV1UXNZS01HR3My?=
 =?utf-8?B?QXpJMjRwV2NKbEwvSjIyeEVDY0c4dFlaWjB6d09ram9PZFdnU3NiWmdBY2tM?=
 =?utf-8?B?OWgwNlRHVVorMnVucXpqWDJ5UzYwVVVpT1pncXJlTzE1VzY5TGZ0dVBtV3FF?=
 =?utf-8?B?WmZ1T1gzdDkxMjNJako0M0pOYk14WklZa2FITlJHaXk2QXdVbEV3YnY0S2pQ?=
 =?utf-8?B?UVFVNXo5QmEwZFM2S3JtR0lkVmhMcTZ1aWhFUkV6cGZ6OVQ1b2FMa0ZsZlRI?=
 =?utf-8?B?SFZ6T1JWMlNrNjB5V2ZCQ2VHUDJwbG5qbEUvb2hydDhUS0RkUUJ1WHpyM2NR?=
 =?utf-8?B?Y0tWcStiMDV1TWVmclp1d0h0VmlCcnFqaTBqb3o5WHFVdWUyU3FxYitaYkZ3?=
 =?utf-8?B?WWM0NXBBUDlwNmcvZXJMNzR5bSt3b25xVmpScVAvZkltbDZ6ZDhqN3kyVnRu?=
 =?utf-8?B?TTdnVENpTThFWnR5bm4rL1VvMUJQbnFESzNqT0FFN0ZZWlpGMjM1aHphUVlE?=
 =?utf-8?B?VjZ3YmZzNFFOd1lNYTRPeTU2cHdmM2FVbFZHR3BHTDlTMjRFa0VyZHZzVk5y?=
 =?utf-8?B?ZWFGOW5hZEdodWRETTJhbkppeUZpTzA1OVpRK21nMHJaUmhFdlpqMHZld010?=
 =?utf-8?B?aVlWUEdRaWo1S2hNc3puUkpYR0w1OUlKbFN6K29aTFpRd01NQkI5TU5yTHRD?=
 =?utf-8?B?OGxJRElRRktqWXFhTFEzSndidEpqYVpSL0k3dzVyR01rWDFKbkNhWTgwck94?=
 =?utf-8?B?cGt3eHpkOTRxTkJPcVdndHJ4YXZRYzhyd0tsYzJ4ZXdwN1o4Qit4NDI1VHRi?=
 =?utf-8?B?SnFGYVlMd1ZhR2lQSGFldzFheVhhVEs1RWxOV2Z3YTZBLzJQZE9QRzU2Vk51?=
 =?utf-8?B?VU5DczdUQVdqek9yendCVDlnUktNQVJEYzBvS0RBOWdGRFZFZzVqZU54NU9G?=
 =?utf-8?B?S2RybnlLYWthemZpMTBYMEFIU3l1empQT1Y4TldCMEFjNk9MVnZFWHhMT29l?=
 =?utf-8?B?ckNHY0I1NE83VWxsbFhhQWNWWTIvWnN3Q3dOT1NBTEF5emdMV1BCalRCMzlw?=
 =?utf-8?B?blZwcEVzUTY4WTlwOWREbjRjd2ZKNmQva1JQMFJqR2tLTVNtS2lUekhpNW4z?=
 =?utf-8?B?Y0NTbytCMXYxOG0vY0Y5RWt3TXZxTDVwSVZoZUE1SnlzdXg0Qjlabmt4dGs0?=
 =?utf-8?B?aFBxVWZFZGQ1U0NaV3ROVFA1VnVjVDZjVGJBMHZMYUNkN2pCNDJqMWxEbk1m?=
 =?utf-8?B?WHc1YlhKSGRFVmtCbWp6M0hqRDZsWHJBZ3VtcXNPV3BJQmtaTUxmdkt5YmRa?=
 =?utf-8?B?ZTkwclhPMzVXMjd3ZDkvYkRZS3lDSnAzWGdoNklMTkxvZFhGWEkrNzVGV0x5?=
 =?utf-8?B?RldiU0YycGZkbUc4Zll5M3ZzNVJCaTJYNlZUbHBSLy93dzNnWmJneU9FU2Fo?=
 =?utf-8?B?S2JSbWVIMmo5bVl3bWg1TVBtSnVoZHFRZ3Z2ZS9MTG5LOUlZeU11UDdycDA5?=
 =?utf-8?B?dWhqckNXYytkTDdlckdoRzhlZ29RL1dramhpRXpVN1E2Wkw1UkJTQVh6VlNT?=
 =?utf-8?B?LzBxeEl5VFBHRG52dW5MODV6cW1UVWptaEM0MmZRbkxYSWJ1N1NRekFyQTk3?=
 =?utf-8?B?MitIL0Z5ZEUrWWM4LzJ6MzA1dENSMk5oQVlHRWYzaXZGL25Lc3JnTVpIU2ZM?=
 =?utf-8?B?Z2JaYy9HTWFKbndpcjVJS0U3ZmFIWEo3Z1cxb0NXNjV5ZjY5bHVkQmRoVXRM?=
 =?utf-8?B?YUVFc2E1RjNnPT0=?=
X-Microsoft-Antispam-Message-Info: kX9kVL8Uae9X1IyfLW72qhwe2YAOODH7f4nlTkDHSN2v/L8a3IAh0vjmLY37m55c3KaCwb3CekORkG8V7pfXAx7/Fa9memuRg7hEtDRfwwUnOKjc0LKcVvfVZBkeJ7W87cyOWjuVf3iK0rYU8glxOFs26nhiZF1u+cieJB1mFbt2gBm467UGC6vVQy1keaZSlrGiLEHeR+4gPQSKLbMe/1HMJfn2Xe49xkHflDaZB/XeUmSSw+X6mHqBSStNgiQVACzJhy6iamao6hfJdlHrCUVwtrt0lexhg4eQpncAbA8T0O8SDiwUaGsfT2dgaWj0Vg9rjP2avTa6ImUkxXi4Ox4F/cGVWlZMLYLApAhx1to=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;6:kG4z1kFqfbrKwDE7C75ZRhpSZWwxTu2oaipZLKIAJ9lGoDnoae5Ke2NeGjOoySt8eVm6M+xwLwfgtLSYpFXW7YTUMgmbZDW9xVjtLZKzpmxnFY0fBQSfzmuiaGgOeQP4prS7UtX0L6Ret6PuTYoNmmZapukmC+qzcw3NZMk0XhGqeEDH6oq34e/NzJeO9tjRamXxjKQVOwMM9SbjanC5rHFjet0D8VcEc2tRfKaAbMi4uv1A7vAuS7TEJZj2U66UXBiAWfp8bIRp1VT6Qz9ARJazeF3joDDwGpadr/AL6Iaa5Ot6sL/DENot/dtLVGUh/OT9J7vRIn1K1yebBHd3575WPfJhv33dDJxiBLvfial9Vc8OI8aO2jRtTsfKIrhPppRGkJIyJ9LtLWLr+e8xyqKMH7j8hqqXxptixxbcoWjRYN0lWC2aYxyi6IdTowEFwQtf4W7tIglw7Ev8rTkCOw==;5:gxrYaIjoS4WYu3BOQQZbqZEnutg2NlCW6OMU4gUhm07/W9p7U/ZVP9MqSF+8H2olwiBI5UcXhMPpSYLSOSePGLMZf8BqrIKn2zQ4namyzIrujo05KFUNIL1h2U7aWdMzJR8MIkq3Nrs5E6HZfD+ZojifA95240wX81dGHUVFtnc=;7:mMl45Y0I1UvWNIUfbN001mx7NeGSMkghETpAmyW+KUNywcF2PextJ70feuhsccUMkUGRVsArOHZcBZybnyIwvGojWXP+uHu2ldscuXJTUFaWlASiBt2+ovLAj+mIOehqJzFXQxbIosDiHu5CvgVHaE/GPYlEIj5JJrVjbfHCQGSz3LOV21MqrQGyI5vP1tinnj0ooZA6wNXD7GVRd50lqjBT+2RjlYeHlMRt0V9tKgDOZpHzFgh6HkzIrZjbHH4J
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:6L5sSjhkHnWelk/C8zpq6rr0c841+6td7fHLbNFl6UqFPmmRdir2Gmc4o0Mi3uanI1/H2LdrLqvQBtFgjNfr6LZn0Om722/89rAARG9v3R3zbfQwuo3NtlmO6pxfpZBJhh1p0y9I2QHDoYeLB0xKTHsX5WsaaqwXS2btGVVF4zLQtRgAkEnD16cDlikBMZLTaUvPrqk/8Cex7DMzYTvuDsZMWePnoF3H0Xcx9CW8wDiwzyVi/ENEmw/tKe2PUtZX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 13:15:41.5231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0faedee-4e2e-48db-b90d-08d6171f82ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/18 7:27 AM, Borislav Petkov wrote:
> On Fri, Sep 07, 2018 at 12:57:30PM -0500, Brijesh Singh wrote:
>> Currently, the per-cpu pvclock data is allocated dynamically when
>> cpu > HVC_BOOT_ARRAY_SIZE.
> Well no, you need to write this correctly - what is "cpu >
> HVC_BOOT_ARRAY_SIZE" ?!
>
> ( I know what it is but I know it only because I've looked at that code before.  )
>
> So no, please explain it in English not in code.


>> The physical address of this variable is
>> shared between the guest and the hypervisor hence it must be mapped as
>> unencrypted (ie. C=0) when SEV is active.
> This sentence is a good example about how to explain stuff in commit
> messages.
>
>> The C-bit works on a page,
> "The C-bit determines the encryption status of a 4K page."
>
>> hence we will be required to perform a
> Use passive tone in your commit message: no "we", etc...
>
>> full 4k page allocation to store a single 32-byte pvclock variable. It
>> will waste fairly sizeable amount of memory since each CPU will be doing
> "... will waste *a* fairly sizeable amount of ..."
>
>> a separate 4k allocation.
> Start new paragraph here and use passive tone.
>
>> Let's define a second array for the SEV case to
>> statically allocate for NR_CPUS and put this array in .data..decrypted
> NR_CPUS needs explaining for the unenlightened reader. Also,
>
> 	"... put this array in *the* .data..decrypted section... "
>
>> section so that its mapped with C=0 during boot.
> <---- newline here.
>
>> The .data..decrypted
>> section has a big chunk of memory that is currently unused. And since
>> second array will be used only when memory encryption is active hence
> "... since *the* second array... "
>
> s/hence //
>
>> free it when encryption is not active.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
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
>>  arch/x86/include/asm/mem_encrypt.h |  4 ++++
>>  arch/x86/kernel/kvmclock.c         | 14 ++++++++++++++
>>  arch/x86/kernel/vmlinux.lds.S      |  3 +++
>>  arch/x86/mm/init.c                 |  3 +++
>>  arch/x86/mm/mem_encrypt.c          | 10 ++++++++++
>>  5 files changed, 34 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
>> index 802b2eb..cc46584 100644
>> --- a/arch/x86/include/asm/mem_encrypt.h
>> +++ b/arch/x86/include/asm/mem_encrypt.h
>> @@ -48,11 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
>>  
>>  /* Architecture __weak replacement functions */
>>  void __init mem_encrypt_init(void);
>> +void __init free_decrypted_mem(void);
> Proper prefixing:
>
> "mem_encrypt_free_decrypted"
>
> or so
>
>>  bool sme_active(void);
>>  bool sev_active(void);
>>  
>>  #define __decrypted __attribute__((__section__(".data..decrypted")))
>> +#define __decrypted_aux __attribute__((__section__(".data..decrypted.aux")))
>>  
>>  #else	/* !CONFIG_AMD_MEM_ENCRYPT */
>>  
>> @@ -80,6 +82,7 @@ static inline int __init
>>  early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
>>  
>>  #define __decrypted
>> +#define __decrypted_aux
>>  
>>  #endif	/* CONFIG_AMD_MEM_ENCRYPT */
>>  
>> @@ -93,6 +96,7 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
>>  #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
>>  
>>  extern char __start_data_decrypted[], __end_data_decrypted[];
>> +extern char __start_data_decrypted_aux[];
>>  
>>  #endif	/* __ASSEMBLY__ */
>>  
>> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
>> index 376fd3a..6086b56 100644
>> --- a/arch/x86/kernel/kvmclock.c
>> +++ b/arch/x86/kernel/kvmclock.c
>> @@ -65,6 +65,15 @@ static struct pvclock_vsyscall_time_info
>>  static struct pvclock_wall_clock wall_clock __decrypted;
>>  static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
>>  
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +/*
>> + * The auxiliary array will be used when SEV is active. In non-SEV case,
>> + * it will be freed by free_decrypted_mem().
>> + */
>> +static struct pvclock_vsyscall_time_info
>> +			hv_clock_aux[NR_CPUS] __decrypted_aux;
> Hmm, so worst case that's 64 4K pages:
>
> (8192*32)/4096 = 64 4K pages.

We can minimize the worst case memory usage. The number of VCPUs
supported by KVM maybe less than NR_CPUS. e.g Currently KVM_MAX_VCPUS is
set to 288

(288 * 64)/4096 = 4 4K pages.

(pvclock_vsyscall_time_info is cache aligned so it will be 64 bytes)


#if NR_CPUS > KVM_MAX_VCPUS
#define HV_AUX_ARRAY_SIZE  KVM_MAX_VCPUS
#else
#define HV_AUX_ARRAY_SIZE NR_CPUS
#endif

static struct pvclock_vsyscall_time_info
                        hv_clock_aux[HV_AUX_ARRAY_SIZE] __decrypted_aux;


> Now, the real question from all this SNAFU is, why can't all those point
> to a single struct pvclock_vsyscall_time_info and all CPUs read a single
> thing? Why do they have to be per-CPU and thus waste so much memory?
>

