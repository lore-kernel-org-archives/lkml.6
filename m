Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE4BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A15C20839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VA8di6KW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A15C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeH3SMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:12:53 -0400
Received: from mail-bl2nam02on0050.outbound.protection.outlook.com ([104.47.38.50]:52746
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728949AbeH3SMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LhqdyQCrvEej5C83dn8hPYQ1BjzM83REywRl2Cz9BE=;
 b=VA8di6KWt6uYXeD5c7UYiBryLzZ7XCTlIKuxk+aLhYyxXyxls35qUZ12LhdlYeyx8l7Nl9iFZkcxpjjnMSgUJXAvo1OFjd7Sha9UpLafz8WJCVxVNuXiqi/AU6CZWiFJbNwyUpVYogRx/s6dlBwwcZgHGrwJuPAshsf8alXR7GY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:6f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 30 Aug 2018 14:10:27 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v3 4/4] x86/kvm: use __decrypted attribute in shared
 variables
To:     Sean Christopherson <sean.j.christopherson@intel.com>
References: <1535567040-1370-1-git-send-email-brijesh.singh@amd.com>
 <1535567040-1370-5-git-send-email-brijesh.singh@amd.com>
 <20180829195558.GA6801@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <8157d535-3b6a-4e8b-5234-ee13f5ffd716@amd.com>
Date:   Thu, 30 Aug 2018 09:10:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829195558.GA6801@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR1501CA0026.namprd15.prod.outlook.com
 (2603:10b6:805::39) To SN6PR12MB2686.namprd12.prod.outlook.com
 (2603:10b6:805:6f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b7d2add-154c-4e6e-b301-08d60e825659
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2686;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;3:r74Cn/vEnhDE7+PkgWmLIhi5A83SSskhqvRr9xQcFfwohQWnWnEVPJi9U8TwYYIB7VBwchvPSJUEb372UQPGp9hJ6DLB/YZoAcapnWxOmuUM/mx8vGfFvGsni1kTbqK9IQ7BqAMVaWXmoKl25j7cVuGR7n+uZ+qH9AcESS3oVBEPnLY3KtxS39kO2vMV21LN4CXtkUt+trUpBkE2aSTwuKLIFqf8gEwhheERtrBhXB04Je+6n1ddKzfZArpmaa/p;25:LQp78g835gtBvbgtVxE+bg7HwmCrVgJtSZ9k2DLhAINS/eZkWUj+D85Y0+1hB+as5d1T/7oeWULQjt3ze7Qaw2FLFT1Iz0W40aNsuI+Am3AWMQ+d1kJtGt+080Odvd65YSIjONbWQcJjwOFRv8FORa1SXkYWmZ5bH+mxIxUcjIzSTe5IkvkfnQjmFidjcUIdzD385FmOyFXrT9FhW63TEjdmj7nryirdi6J17hayMjN/GkzXn4vaac4RLa1JgOkeQEtfwYNNrDdCsIFXddvHDyQ96Br9dzkDn6KKd23RVwnw3UGAme8MpYmv4b1GF11nf1gLOJpTzXGPwZ9yxEP/zg==;31:0hJ8cGNpPBUf9p4F1bNXv0OTXlcJ77Kh3wl9sB1oL3WKQLWF5HzelC6fxM9S88JDYBrfFLoYRBsq965D04PFkVpfMrQJKsnyBZ+vgiOoPlmoowJlSTeO1SRsGIo3HfbTWMBm+zgw9/NyGdNKQjbewLitm5NZmHLx6ZXVE0yn9TIW7I50UgLMr3D084leL2U+hLZjF5t9GidBDI98AKSKKxMFt7q3UfcVxSpbT9DiJEk=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;20:aD7ReGfI0EmtY/6WnhxtoXbJoRWylKRTBgtCMNWGgVvvPVXaKMrwCZUECgVAyGyLQ6G0RlBG5DGzkg+LgNp9E7BK9tER/pz1boznl0bCSGCAx+Z0+qFXq4yuWXoZEwgWqwB637lGQn1KOlmd8M67fdBGq0xtZp8ssrM44rGyMC0E+Ivn2sdB2fjQs9PqfAnwF2B+O3qW5cHBxwHsjld6rcR7+qIVrXdUyxbp2n49jPuFBftqifLIxXnorvvP5g/F++PovjIAOl2AkQipYbXqRJ/Qm8sx6h3RFMjFPgjar+MU6ryvbnxj5n/56G6tdnc1ShYJluycOgMTbL3mre5NXQ+Nu7Pgil0uGp3TrHO8tTH83IB/T3L7rlOXMbmfkZzzH2Xt6VjNd5cJAH5X3CySlrPLsagXsT2OzymkGqXP6m1W6HY/5XxOIAUQHXsjMdy9YF4KrZUw/w5wyiPM7K4NOAr3koQN2jDQI8S4vR8OhdZ+cBLrRj0syvCcvXC8EiS7;4:+kyIuoJtTica6q9hmJNbaVVbgGSmJNo2f4FaCYyD6afXY9bNPLiv5d5F3DGOR9vw/3FMv2GSTZ79m4EZJBaSGYd0ISjQJEU/HpJzLJY3Kh0GWT3uW6yDpPpOuDMq017bOj9Tk5WH8eyG9scIitm57iSvtGhrRDEs0eTIbL+m7Wel9jpnrcqqE+ZapySgtQSU26mL7cu0dTEC/lRGbMSrGyFHGhqGn3sxAxHDIrMmnzfPV9YYZ+EFpIgt1syDOzRvMMSuIMgyKnmYmSGl/edJly8huXVOdMcKT/fA2ujwc6WTHps+IAxJA8bYgLq62HEez7VtMT1r2BPAf98T1EMOcuinBALRSfZ+DKz4akqaKb8sVdelZI+E1lA9IRqIkUmK
X-Microsoft-Antispam-PRVS: <SN6PR12MB26869166CFA9C36A1880BB7DE5080@SN6PR12MB2686.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:SN6PR12MB2686;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2686;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(6246003)(305945005)(16526019)(81156014)(186003)(77096007)(7736002)(6486002)(478600001)(68736007)(956004)(105586002)(31686004)(11346002)(106356001)(81166006)(44832011)(486006)(64126003)(2616005)(476003)(53936002)(8676002)(53546011)(8936002)(65806001)(6116002)(50466002)(47776003)(66066001)(76176011)(386003)(65956001)(446003)(31696002)(229853002)(3846002)(2870700001)(316002)(4326008)(6916009)(14444005)(86362001)(54906003)(52146003)(2906002)(65826007)(23676004)(52116002)(58126008)(16576012)(97736004)(6666003)(67846002)(5660300001)(2486003)(25786009)(36756003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2686;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg2OzIzOjRpM0J3Nnc0UHc0K1pEK3kyeDcxVFJLVk5l?=
 =?utf-8?B?YmhMWjl4bTF1SlBySFVtVHdFOUdFREtNQWxJemx2dmtVU2M1TG14M0h0aC8x?=
 =?utf-8?B?UnJLaFRVTTRNTCtuQmd1aDRjTERxaW5KRGk5akZCTFcxVHVQMHliTUJLa0U4?=
 =?utf-8?B?UkRNYWRDcERhdzk4a0JtQTYvRitkaUVwRkM1aHpQQStUdDNkOWFUeG4yWmp0?=
 =?utf-8?B?TTBsb2VIZzU1czhuWVdUaVExNHAvSXFUYmorRzNodG1RTXVQK0c4ODZIbzVG?=
 =?utf-8?B?bGNHZVJnMVdMcTY4QVRVQzQ3Y1RJaHhKZDRGVEd5MDdEeEk5Wng1MTNRTjRt?=
 =?utf-8?B?ZC9uN3dNNm1mNWtBMkxBNTZvdU1DSitGZDYrT3A3MEtRcnBoZ0U4NWc4RzJU?=
 =?utf-8?B?UjcxVXB5QXdFTDlzZWc5MVVKNFN3V0pVYm80QmJWa0tpck1CUUZ5RThNcXla?=
 =?utf-8?B?ZGUvTFBHYW13Z1plbkV6ZjYvM3ZzZjgrRDcweUQwWGVpcUNZM1hXN0ZjR1Ax?=
 =?utf-8?B?R3RNK1pDU3huTFBJMjlqbER5dVEzSkhSQlhadkhHTUtDVENLRFJZWE96dURR?=
 =?utf-8?B?OFRQYlBRWG5WMVUwaExWZGs2TEtZK0V4NmhqSTlSb2tlU0dST0d1YU9vUTFP?=
 =?utf-8?B?TVZzYXB5NmVGeUhDS2pOY1RFdE5GckRnbWZIRlA4eG9CZ1pRQ0dzWng2Snpt?=
 =?utf-8?B?U09Fa2J3Y3RzWjRZZnFsN0YwRDVTVkxKTFBjZE1BSFByVVdPSVZjVzhJeEt2?=
 =?utf-8?B?VmpLK1AyeGdYeVhwWC93WlJyNWY0YVlQd3RjYkJGYnZFZnZqdnJlZVRHM2F0?=
 =?utf-8?B?YmtldCtvTDFWYmgrTW1IQzRDSk1wcmpHV0M0cDZGL3JVbTBpdnlKcGFBUDJE?=
 =?utf-8?B?b2h4N3NHWFRROStPK3g3a1hZL3pNN25JNk5aYnFjN1FTemRWSEExTmFUK3py?=
 =?utf-8?B?TlNtVUhONU9aYUlDQWl3OHQzYzFoZHRvc0dRbW9meTZTNFNFUnVRZlhjRGpz?=
 =?utf-8?B?K29oTVdCWExzTnZQalkxb3dGVGZaOXRrVzJhRk54bnllcmhUOVZvQTVWTWZU?=
 =?utf-8?B?Y3lhbzJEd3FyV0VpSjNPNkxIbW9DdlgzSXdjS3Jadi9ja0Q3OWYxTzRlRm1u?=
 =?utf-8?B?cVBQOHVkYUVtYXhHU3Rnd1JqK0lsdTF5a3pwb0hpRHVSSjZYWWk1Rit2Q01Z?=
 =?utf-8?B?ZG8vYW9lcFdramNVSWlkdkNyZTc3UlNKcVY1RFhnaGJ0WjJzeE4wNWdsc2hn?=
 =?utf-8?B?K3hGcjc3OE1aWTlQeU5NQWIrQW9oYzdjN0l4aGlmWDZJZm91cVZsS3V6TmVr?=
 =?utf-8?B?VnUwMm0za0dmMkhMTVpIWDlzSUc0cmNoWjhNNWpHQWpoUmRzZVE5ZFBkZlhK?=
 =?utf-8?B?VXhVTGFuS0UwODFxM0xOTG5pYVB0Y0JLd1BYRDhjUEljay9tZjc0TmxXanJq?=
 =?utf-8?B?Y0tQeFZhM1FianBDaGdqSjIrSUZVSHhRSmc4REJEWVdJRFc0TCtjZ3FqcEhj?=
 =?utf-8?B?emhPYjJQNjY3T0g0VzFSU0MxYitmSXRheVNnWjN6L21Qb3d0bHZwd29KRng1?=
 =?utf-8?B?WXdQNVJXanNNSm5UVXZsNUtOZWFvRHp5TVJ4ckcxTjJiMVl5ZFdjV3ZUYjhR?=
 =?utf-8?B?QitZcCtEbXB6TmhoR0JRamhrV2dSbHJ1Y2l2am9FWHVJanBrbEVvbWV0QUhu?=
 =?utf-8?B?b01QbFV6WjQwN21uT2Q3THBoZktnem03MWRCZjBDM3loNFlGZmRJRGw1WG51?=
 =?utf-8?B?S0FsTU5tTUVMWEFqTnRYK2JRK051ejRCclZ6NFhWbVZieFVYT0pxT2hQVnVO?=
 =?utf-8?B?Y0lOUkFiN2RRWEZEWEs4MzNIclU3MnhhNG8vUWNLWEpNK2hNaVgveHhzaStR?=
 =?utf-8?B?S3h0TUdUTEtIZWlHVThGSFJoNGtIMWxqZzV5VVI2dVJzZlNYUG9aYkt6N3Vm?=
 =?utf-8?B?b2ZnSkp5YXc1VmVIaVdhcldyMm16YWxpOHVoNjloa1V6UDUwZFNMNEpFZDRX?=
 =?utf-8?B?d2tnLzV5U0tialo5ekNaOVNQYWJQNC9CQUlQZz09?=
X-Microsoft-Antispam-Message-Info: spy/NkwOtHDiHwJcE0VRnLwATwdmPFABQLaJWmVr615DGkP1LVF7EXNI2G5H+dEpmV82JKGkouX5K1NZ7ftqAp80mgH8xtHedRbcDZKco0OzXhLJEMyV4o3c7inxv72h1v49xxa1K0+bYx7fhtgFo2zZF73hPZhR+w9ceuuaiodqfaSzHS2W7uI65dOTkGCAvuv75NBOI/TZh5MncbeIH0lhWl10u5TpNgqRLNWzOzBvSuWcdaGD8N4Ri1ce9SMw9+Vhjw6y0I5yZakTz6e4+aiOBgAOrLXx/lgkhWRt2NxwUy/ecqQsUVFsd+l8JF+isMY4GJoeuhJnTMltsBliVJYi8a8Gta+uF6Dy81NLwWY=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;6:II6bU8kWgJzElp1W/v/VkGhkG4Nod0ImUriE+fHbaJ7rCU/lS64vWkZLkJ9ZCUPbw+mlyOONzqgllQRl8C6NhLr6+AZQdj5lFPgwuDs59Ao8JajuChxhTya+ExR5r4auTv0MubRvS+unDWiDgisC1y6X/J7bK09ACwIO9BPnQJ4QucjsH1xgXAnsSz4Y47n7VkZdTIk1hDgAgPV4PduTXhaFYUPF/+ug1bwOU8wKA2s3n2+8yPdcg48X8QqjX1THfk1wA1bmmqbEtQPC0GpNMW7rxx+rUA53HDCV97GNLxyenRX/Nm0Gs8CYgy2Jxv4z9iqC/uL/Y+gduLRZCbJMnzZqqj2+IKmUkuDzW3qFNjmwoywbcF3sLkl6eW1qoVWdL73bu/OM9cwb07oF1e7hHeQXoGFnOb3kJBuINtJjv017cCvfXHYBIbaHr0BpH0QPdAKJcOYaA5+/VtMoCYWxFg==;5:MFLCJl33ROtt3U46HG1bYPe5VjA7FOfYogYemjTabVyM2/S/h6GZvMd/AX2Foqgmy3uhxwEyA7ohBszC0O8f4033GUd6hUj5B+qlHV0DV4I5St/msyhhjHOIRnJsIS80yYlqO+AmYHVeyCCI0b0JmO3jdkhQpro5Xk+D7Ti2ZGY=;7:hscPOk51ovE2lbosLnZR9tIAextfJyCbG4lPyiPxib7BrF/MHUyrw1hSQztCrQmYfX0+OCRwbq12ipyrYnSHP+5jgnKE5IbmUjP2q1BbrM6xu5ApmMM1H+JJ6/nUsk/Y7vlpKqGaD9AgQY6pgF8ypPdSMcyqoZnm81Uaioo16ZhGcqvGhSG398E5Vck4S7G2YR1gx05Ug6BAgQI/6EbWbroLkuVEggxLL1h2v30I5t/1S9no/KUDxebrvJ21tuAX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;20:QJjzEkBQUFMrLo8r60vQITPaHKPkqm+hw957aCbs8kOaubkb6+eIjhwpIrokalgZbt7LPMLVgkUfdx1FARz5fr+BOIdzAvWqCP8jtS/rvWNK4plphXW4/PCWS9WJ0E40NlDW6rl/N0FnHui0tFVHrphtr+dd+dhYBapCQ3X11amNuO7R2wNZqlQGVnSOsGcdQdAXALzXVbMX3pVd9YdLu/J7EeAJC3VrLov75kbHgS0w/Hi9FA9jHzZsyXrtsaUT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 14:10:27.3237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7d2add-154c-4e6e-b301-08d60e825659
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2018 02:56 PM, Sean Christopherson wrote:
> On Wed, Aug 29, 2018 at 01:24:00PM -0500, Brijesh Singh wrote:
>> The following commit:
>>
>>    368a540e0232 (x86/kvmclock: Remove memblock dependency)
> 
> Checkpatch prefers:
> 
>      Commit 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
> 
> That'll also save three lines in the commit message.

Noted.


>   
>> caused SEV guest regression. When SEV is active, we map the shared
>> variables (wall_clock and hv_clock_boot) with C=0 to ensure that both
>> the guest and the hypervisor is able to access the data. To map the
> 
> Nit: s/is/are

Noted.

> 
>> variables we use kernel_physical_mapping_init() to split the large pages,
>> but this routine fails to allocate a new page. Before the above commit,
>> kvmclock initialization was called after memory allocator was available
>> but now its called early during boot.
> 
> What about something like this to make the issue a bit clearer:
> 
>    variables we use kernel_physical_mapping_init() to split the large pages,
>    but splitting large pages requires allocating a new PMD, which fails now
>    that kvmclock initialization is called early during boot.
> 

Much better.


>> Recently we added a special .data..decrypted section to hold the shared
>> variables. This section is mapped with C=0 early during boot. Use
>> __decrypted attribute to put the wall_clock and hv_clock_boot in
>> .data..decrypted section so that they are mapped with C=0.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
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
>>   arch/x86/kernel/kvmclock.c | 30 +++++++++++++++++++++++++-----
>>   1 file changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
>> index 1e67646..08f5f8a 100644
>> --- a/arch/x86/kernel/kvmclock.c
>> +++ b/arch/x86/kernel/kvmclock.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/sched/clock.h>
>>   #include <linux/mm.h>
>>   #include <linux/slab.h>
>> +#include <linux/set_memory.h>
>>   
>>   #include <asm/hypervisor.h>
>>   #include <asm/mem_encrypt.h>
>> @@ -61,8 +62,8 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
>>   	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
>>   
>>   static struct pvclock_vsyscall_time_info
>> -			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
>> -static struct pvclock_wall_clock wall_clock;
>> +			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
>> +static struct pvclock_wall_clock wall_clock __decrypted;
>>   static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
>>   
>>   static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
>> @@ -267,10 +268,29 @@ static int kvmclock_setup_percpu(unsigned int cpu)
>>   		return 0;
>>   
>>   	/* Use the static page for the first CPUs, allocate otherwise */
>> -	if (cpu < HVC_BOOT_ARRAY_SIZE)
>> +	if (cpu < HVC_BOOT_ARRAY_SIZE) {
>>   		p = &hv_clock_boot[cpu];
>> -	else
>> -		p = kzalloc(sizeof(*p), GFP_KERNEL);
>> +	} else {
>> +		int rc;
>> +		unsigned int sz = sizeof(*p);
>> +
>> +		if (sev_active())
>> +			sz = PAGE_ALIGN(sz);
> 
> This is a definite downside to the section approach.  Unless I missed
> something, the section padding goes to waste since we don't have a
> mechanism in place to allocate into that section, e.g. as is we're
> burning nearly 2mb of data since we're only using 4k of the 2mb page.
> And every decrypted allocation can potentially fracture a large page
> since the allocator is unaware of the decrypted requirement.  Might
> not be an issue for kvmclock since it's a one-time allocation, but
> we could suffer death by a thousand cuts if there are scenarios where
> a decrypted allocation isn't be persistent (VirtIO queues maybe?).
> 


The .data..decrypted is used for storing the static variables (which
need to be accessed unencrypted before dynamical allocators are ready).
If caller does a dynamic allocation and want to use the buffer as
decrypted then she is responsible to set/clear the C-bit using
set_memory_{decrypted,encrypted}. Currently, the decrypted section
holds the wall_clock and hv_clock_boot variables but its user will grow
when we add SEV-ES support. In SEV-ES case, the GHCB (guest-host 
communication block) need to be accessed unencrypted very early during
boot.

SEV uses SWIOTLB for DMA buffer, the buffer pool is allocated and mapped
as decrypted during the boot. For the SEV case, Virtio uses the DMA
APIs to allocate the VRING, caller does not need to map the buffers as
decrypted. Actually there are very few number of 
set_memory_{decrypted/encrypted} calls overall (during or after the
kernel boot).


> Duplicating the full kernel tables for C=0 accesses doesn't suffer
> from these issues.  And I think potential corruption issues due to
> mis-{aligned,size} objects can be detected through static analysis,
> build assertions and/or runtime checks.
> 
>> +		p = kzalloc(sz, GFP_KERNEL);
> 
> For the SEV case, can't we do a straight kmalloc() since we zero
> out the page after decrypting it?
> 


Sure we can do kmalloc(); IMO, since this is not hot code path and doing
kmalloc() for SEV and kzalloc() for non-SEV does not buy much.



>> +
>> +		/*
>> +		 * The physical address of per-cpu variable will be shared with
>> +		 * the hypervisor. Let's clear the C-bit before we assign the
>> +		 * memory to per_cpu variable.
>> +		 */
>> +		if (p && sev_active()) {
>> +			rc = set_memory_decrypted((unsigned long)p, sz >> PAGE_SHIFT);
>> +			if (rc)
>> +				return rc;
>> +			memset(p, 0, sz);
>> +		}
>> +	}
>>   
>>   	per_cpu(hv_clock_per_cpu, cpu) = p;
>>   	return p ? 0 : -ENOMEM;
>> -- 
>> 2.7.4
>>
