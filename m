Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59682C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E766F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="vLggaWUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E766F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fortanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966835AbeFSPou (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:44:50 -0400
Received: from mail-dm3nam03on0137.outbound.protection.outlook.com ([104.47.41.137]:6158
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964999AbeFSPos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector1-fortanix-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6CBiumz8bR6Q2c7vc0uj0Esm/QuhRfy5LP2W6QtN6o=;
 b=vLggaWUk0Xs8cWpT6jaWfhmwfbiqORLxehBIpAtIj3/sTftJzJj6W1K3pey1h5rvSQHBAkz90x0pR/6l0ikEaAu2PaUAlt1/I1XhSeF0tMsPOALQh2ZR+Hc+/sgvR5zh7VwDvHnAEBxycEu+GJoB9sZXUT33uWS0EB17drIcWUc=
Received: from [26.194.140.120] (172.56.39.23) by
 CY1PR11MB0315.namprd11.prod.outlook.com (2a01:111:e400:4c54::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Tue, 19 Jun
 2018 15:44:43 +0000
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page cache
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
 <78982a32-c589-48e2-9a83-fd36903b5588@fortanix.com>
 <20180619140815.GA8034@linux.intel.com>
From:   Jethro Beekman <jethro@fortanix.com>
Message-ID: <aafa64b6-b5a0-fbfb-8b1f-995044745ccd@fortanix.com>
Date:   Tue, 19 Jun 2018 08:44:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619140815.GA8034@linux.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060204060202090707080307"
X-Originating-IP: [172.56.39.23]
X-ClientProxiedBy: DM5PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:3:5d::12) To CY1PR11MB0315.namprd11.prod.outlook.com
 (2a01:111:e400:4c54::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d009d55b-b256-410d-22d2-08d5d5fb94a1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR11MB0315;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR11MB0315;3:gXmOTqRzRQWsEFUk0luwmAZPEsNkC0QZqY4Vvu7hrQ76ml/40OVcgNdWhhnJla9x+le/ryTPkeWCxRnVYRuLZ3klM6hgNe8+4heBJMiiQ1XUIIdGV0Pa5+zDPnbUmq4SSdjKIKLTD3UQGESBNPC/qNtoo40gkGY/VssA/aH1ypYNKGAbYLSW/VzTrpBZ73fG+6IF2uSAUB1+UoZ4vvaaLRAYTCylyN2v+8747WztJUW1X7wVXrAz6TlQpjy+G0xW;25:jnC8JUCmgJ4Se8+QOSJktJ2JlilyotISesjhKvF/15RlFy0uajm8yFEfnA1U4y+pXAeGKzMq1aE441lN7HVyIrXW7kRyg6N/ui05q7Vverr8JfDmfcmHZjxtn3nBdLkj3sKJL/7q6HwYErQ3JBpVbM+mx3W2cr1Tab9fjYxhuFsly15jtZ9Gcm6Zu4UNXeNCbwPm6aiIIEo3wOZasuAGdV8rMKrG0UVjmXPIYBnldLRnbYWTc51WOzFKjRNt5gmZaklOSfaL9Mt9J6FCVYJAshnfyl9gY2Ztd798HVfno3jl5q7K84hMVHc9JhZFQ1NcV6oj/wcO//VUyHtPYnBr7A==;31:xxUlse+lhRW+YLMvuOs9vDsfRKFU3Q87W+4EDHWrfoxYyvhvgbyr+oOMZZswTqljxssQv60tLTR4BpufvDKKLYPdS7B+zUVJSlPvDoZbZNR3bZ0U3TtMtLJqsAwgDoDBMZ6GW3Wfsngpruz2ZrbP26V67bc5xkOMSAK9AFqqTHqy/i+zyjWUxDX5cHGr9xUzCmUI22hqLZc/35GyxFF4VQjA/FfFzCAgWKFvJA2rqo8=
X-MS-TrafficTypeDiagnostic: CY1PR11MB0315:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
X-Microsoft-Antispam-PRVS: <CY1PR11MB0315027941178A368BA04AFEAA700@CY1PR11MB0315.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CY1PR11MB0315;BCL:0;PCL:0;RULEID:;SRVR:CY1PR11MB0315;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR11MB0315;4:wDx5Iv/4ulLOir2ih5nAwAY/rVwVxTT7tkUaqkRh6tR3ZeIUplGQrlxwysQ1adoshWvr9eiLn1ZKqZCXOyHw4POwurD4NcuZjVgnKoS1wcVu8PnY0x2KjxwQdkYhhCEFNP5qyZcF4gfeMFwk0nVc1GrEycoBeepbVV0YPAW2u5WjQ899W4aI+v8pdcJlIAimBtr9D9zdAfvTR+hOyQle5x5Z8T06AYV3T4xF3gkDREIwb+j0kTB9huHwsQfdyUi26oabk8mTZvmMb8ish8ywkA==
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39840400004)(39380400002)(366004)(396003)(199004)(189003)(49976009)(8936002)(2616005)(76176011)(33964004)(446003)(11346002)(52116002)(5660300001)(53546011)(7416002)(386003)(65826007)(956004)(3846002)(568964002)(6116002)(6916009)(186003)(476003)(8676002)(65806001)(81156014)(316002)(66066001)(81166006)(105586002)(16526019)(26005)(65956001)(106356001)(7736002)(25786009)(36756003)(16576012)(93886005)(5890100001)(2906002)(4326008)(97736004)(5000100001)(6246003)(31686004)(6486002)(31696002)(54906003)(53936002)(86362001)(478600001)(486006)(305945005)(64126003)(16586007)(68736007)(58126008)(229853002)(84326002)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR11MB0315;H:[26.194.140.120];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR11MB0315;23:uABDRk6nEI0nytbx9C2GMLsd7Wv3mFP+W261cfPLj?=
 =?us-ascii?Q?iH7dHCGlmAwuy/U5G1VEvNR86XDWUHgtocRJ2UG1ggkY1oOJI3Px9N+lWuJq?=
 =?us-ascii?Q?8oDzSqXvLb0LElauv7qejPLxZZG/mKrZmJ4/ZpWGNL9NKLvXiHU7b2s4aD8B?=
 =?us-ascii?Q?tguto9wQx23Muzg1o1W+gQBIOlgAfuBrNMYq9IfNt8u1hoWd5asGskie0Q48?=
 =?us-ascii?Q?u3ZEJyFuXKptqPvAPHKo2IX5ZT1CXKbYgjEaFfhrDiu4H0uZ+DoCaL645viP?=
 =?us-ascii?Q?m0YAJobC7FCFm059rYbb7ByCSQ7AKOsds27Z0j/A+YGbjFSjz5EYFEVu+Z9+?=
 =?us-ascii?Q?hYRV7GEM+9lJw4qEai/t0K1Cm6kJYF5IUGYkTJwiq5JdHCSx4lYUs0bDuacA?=
 =?us-ascii?Q?LzqCHkUmkyrVhEViglhTIg+71bdhdPAlo64ySn2anQmZXDMWxStPNVjrg1ei?=
 =?us-ascii?Q?W9UIfQOIBNwpmMsbK/uOKH2Sm50Jn6qBfv+64dC/19ZaqnSh4PslXnL7kyHe?=
 =?us-ascii?Q?Ji6BIxdCcEgPjfSGw9/QuZkCZAP5AzN6qVRFUTQRMTjeghXOqTjX1b2UWJR/?=
 =?us-ascii?Q?g4FnhoA2gbDlylmh/bBslc9KA/bp0CxA6mvr6vjJl0YRf7yPgKOkFYXIeyLC?=
 =?us-ascii?Q?PTs0CfFbt/J7GIoURaneV+rMbSqhPilcQw36SbIaBqo0G/aatqAFlH2Mo4ES?=
 =?us-ascii?Q?Z2gQcO2GVnOoNsUi/IF+9NZw7ShKQ46cxlQ61dhAJB9BB7fhxzUTcIoXFkqV?=
 =?us-ascii?Q?Ozcecvr8sDiW7H38qsj9FqnpfIwwphXAuklfmfgOsZjO5EpA6eQVERrVVjtS?=
 =?us-ascii?Q?3oEBYTXGxcKHnl/i0T0bLspg69ZREjwdw7+nnYuCaNJ5nsDeLSVlw7UschCf?=
 =?us-ascii?Q?CTSaV03M++SvrHYRUjnQceal2IuFoa2Qc2rsjB1ZcliMc3ZNgdKdiMmtTCiY?=
 =?us-ascii?Q?yTHymQ1w0fxNQvpO3MsjZjyrdWFlKtj9sCmQ0YDdQPIzazuq/rJSIwQ1OsVv?=
 =?us-ascii?Q?FtFJVEsRfy24fc0NVxMbRuvQfYwHIAnGC6U9v739i+KJAhW8syzucULE2VX9?=
 =?us-ascii?Q?nlUWdYd575ByX7yLnXJQd47Wq3wLx85TNUHrmeqFiL+k4WblLNzlHRjMniHW?=
 =?us-ascii?Q?L9DT494o810tXPCmyPQNEHcXyyMlPS34UO5sWPiNhNw5iU3GCNv7JDmK7U0e?=
 =?us-ascii?Q?Yr/Qe7Wg0JxmustvApYrC0zqwjMKaGKAxQFVfjuEbfLtXQzW+a4N+xD7O/oh?=
 =?us-ascii?Q?f910ZYEsQou97Bt7V0pPL48yZoqprCD0hUmcjartCiLLfOfKv5iNsyNaMdrZ?=
 =?us-ascii?Q?nQvt0Dxm0vSvPQRc2oThyovDr6UDfCOOmSLNh2r3QZnnds+3NUTN0LpZQ3hX?=
 =?us-ascii?Q?V+m9GoCuCabBJ+eEgDpkAa2BEk2KpNGH9cZYVDJmDuzhrwYd6Gg2X91kVD4e?=
 =?us-ascii?Q?afjFHyAmtj8+75v9OeN/mrNUnztATcKS+Ak+/wCS9zU6TCacxysC/3f4rmtk?=
 =?us-ascii?Q?YS06m30dcwCbA=3D=3D?=
X-Microsoft-Antispam-Message-Info: x9Ao0MRsE2inPDA8QqPtHn1dWv8AWNBArsHfhi7RieTpNMSs1KbnYJsjgGIJkbx44QcmMOUVbe9OoEinoc920SZ/pvDc/ZgB0JnmLnswpsdLHowtZHLvKAdrvDa7KuB6et6Rm2Sc4P5fJbo3YrEtwqcRNdb73EgL/7fEKJZFWbSN31HTThRPrlw4/XVYzlPwtcFmtI5cIO424l40t5dQWDzD8PW9dNyafJFsbSjnOdjbgt0jY9raud9m8wNfqjOrD9GOJh7qhQv73XOvwBiDfkUlaydtNYfHkQeBBCJlV1Nk7mW+HT0D/EIfUi4UAdGVc3xkIAeDFgr1HcrPdAzdyw==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR11MB0315;6:m2Pxv7SLFHgNV6tXlIZSxau9NR8rJDvReaINjj/jMJFJcSn5Vs4U8qHp9KXAw8ckI34EcZGdRstHUMlVuU9m0hIWEeWdwJxsgeju8V30V6+wCUy/VqEgvfT3oDuyKqbfYZzq1vconf4PNxqO3XPCqAkpbORbxWj8cx/4lbBJDKC9LNVsV80lKa/tuyCBcfIa/MdBe9T5txbCSn7vWGzdnFZaFWI3U5LP0vzf5FwtSbYEytU6H+Bg/A3wFNpdEBuQPS5J/Onm2OM7FsA2uJgUQKuS2Y05u4JSnVE7VQqChFVh0YsJcadUvo1AjzcX035jF9R8aZdqfT5oSXUxB7s5Suxv7PoEVmbA202+4SkwBoLCj6xz1SvVKjuC0LV6qDcybcN4hO2kTRQVBe4X4EoUJFrv7ON7J5Z5rN5+5tJnW5Ws0Z5Bq9WwHIJl359N/fvgasGmnRMFNeQaOPFUwzJYBw==;5:3LByIvV+WQV9HYDNpAjziZEvbJx6GLWeKjA7nMr0LZR9VTS3by6u3vKWnjY6QXnGOFXAv42+chnAvFWbzFMNG+NPgyHsgauUP5oHSrdE5WPmmaSf4FI5essdUNogMNC5q/R1BFVLOGy6DSwINwUe/Ztqvvd7gnUiVXe7po2yOD8=;24:Bq3LopHh+9A1t7SlbZlypmlDslRyNLGEhi3E5MxZOLmNOUlCuTtxLeKN5iAkPHqU/Q+uTMOhg1xpJy8cVVjH8w9vxh2vpHV7U7PzRwwfF7Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR11MB0315;7:hACCdGQ6U/pGgPygGqfz9eqO4eAtwt7XDANwxuvjtwjPJvBOkr/i/Ps8UICWHAQ++rjoZNWEj2ZEWxAiBJTtKHeRtAuWPnwPEA4nSyy0/McYM4AF+S+WXuzLeBNPRSBdat5octFZ7B00nuxc1huMnu8BE7x11Kc9msV9hP4eA8yoczzuKPyyGFkY/kRZX3F2IdytOGhbS4PeNnOKo7NfZslI+mk8b/Ka7NmIVl34RPj1/yOeF6r0WwVFUx8ehXVJ
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 15:44:43.2915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d009d55b-b256-410d-22d2-08d5d5fb94a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR11MB0315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060204060202090707080307
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-06-19 07:08, Jarkko Sakkinen wrote:
> On Fri, Jun 08, 2018 at 11:21:48AM -0700, Jethro Beekman wrote:
>> On 2018-06-08 10:09, Jarkko Sakkinen wrote:
>>> +/*
>>> + * Writing the LE hash MSRs is extraordinarily expensive, e.g.
>>> + * 3-4x slower than normal MSRs, so we use a per-cpu cache to
>>> + * track the last known value of the MSRs to avoid unnecessarily
>>> + * writing the MSRs with the current value.  Because most Linux
>>> + * kernels will use an LE that is signed with a non-Intel key,
>>
>> I don't think you can predict what most Linux kernels will be doing. I=
 think
>> not initializing the cache to the CPU's initial value is fine, but thi=
s
>> particular argument shouldn't appear in the rationale.
>=20
> Are you just referring to the last sentence or the whole paragraph?

Just the last sentence.

> /Jarkko
Jethro


--------------ms060204060202090707080307
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CyAwggUyMIIEGqADAgECAhEA8MVmReo60XmFXNF7R8+qGDANBgkqhkiG9w0BAQsFADCBlzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTcwOTE0MDAw
MDAwWhcNMTgwOTE0MjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNqZXRocm9AZm9ydGFuaXgu
Y29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAz7i2PMd8+ac44evn+E/vAnvp
p3rSuGpPBG8a5a7TomxjN1KilgX7juFiY7LZjZZe955hCzCoou+lyNgCCSbZzcKsYuIyydkj
UBBGIcTSblxCbko21J3yyk0JwAwSoaxlZwKrsbjUTHSl/0E6SBQpybRZsAficbdSRz+s7jG7
f6DtnikAtTYof+mBxwZC30Gzxh3RQEjA0PwaSP35tXffrplfazeog099eiVWLIDYA/kSaiac
SgheMK02Wi0Iu0fGZ3Y9QMVaB2r5Bhm+hODvJv/WAjEUuZGwo3K4aR/934W79pq5bXwUReXy
/5VxE1acjz6rFnCqBJuNgrzDiGF4ywIDAQABo4IB6TCCAeUwHwYDVR0jBBgwFoAUgq9sjPjF
/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFH990qeqLXTAXNqiGOMUQIhUf9TWMA4GA1UdDwEB
/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMF
AjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggr
BgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2g
S4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklo
dHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFu
ZFNlY3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5j
b20wHgYDVR0RBBcwFYETamV0aHJvQGZvcnRhbml4LmNvbTANBgkqhkiG9w0BAQsFAAOCAQEA
BzIiuD+ggLjwfH5xKn7eotgwkH3V6qCWD21G1++PIxuLjCzRN87rMOZcmrMa2HJkDVz4NZYe
Er98p40JKNNVabKBI8+aF79Gfl0y3Mojr53ojV+x0wt2U04EmOXONuCHdLgxv5JvReFLXo6h
bIZQoe4Cwfgj541QPLDzoSuMrMUAcNSjt6o/SIeIu+Udv84ET2YckxiBXDiKUXRfW+GWet3w
1tUYrUSfwTA7Ho2YUbZu/L4FFRrUXQD6zYrB3f0sStDxWijKsRwLrdzqKVs0hsu42wZcNR/v
YzWnJQBVuCIpr0I/rTHY4E8w5h0Hz5mPABkNxLfOYKRJ1VUMQSgHGzCCBeYwggPOoAMCAQIC
EGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYTAkdC
MRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQ
PTRI5Or1u6zf+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivl
JTRENf+RKwrB6vcfWlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG
9qrxpZxyb4o4yNNwTqzaaPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoS
WY66nJN/VCJv5ym6Q0mdCbDKCMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQAB
o4IBPDCCATgwHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKv
bIz4xf6WYXzoHz0rcUhexIvAMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEA
MBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8ERTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9k
b2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBxBggrBgEFBQcB
AQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUFk
ZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJ
KoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2SQgG1NgvNc3fQP7TcePo
7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs0j8CGpfb+SJA3GaB
Q+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDMKVmU/PUWNMKS
TvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+E2pvOUtY
+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfHM5td
hYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJ
M/1tyZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJU
mpvVdZ4ognzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTK
TlL8YXLI8nAbR9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIEODCCBDQCAQEw
ga0wgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNV
BAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01P
RE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA8MVm
Reo60XmFXNF7R8+qGDANBglghkgBZQMEAgEFAKCCAlswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwNjE5MTU0NDQwWjAvBgkqhkiG9w0BCQQxIgQgrOD4
7lgfLY5jEag9Lo1X1lx/MMS5olDAbop9sQ2GJYwwbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvgYJKwYBBAGCNxAEMYGwMIGtMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5
hVzRe0fPqhgwgcAGCyqGSIb3DQEJEAILMYGwoIGtMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UE
CBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01P
RE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5hVzRe0fPqhgwDQYJKoZIhvcNAQEB
BQAEggEAAeufIcHVF37p9zCZZi4ktt//uul7YFAc8Gj+LT9Ay+IxmEdOOKuTPSdBgjszLEKt
cZyZpCzX3hxUujjX7Pa/HyY9Nkzncuk42g0q2SNhX7CXSlRKMKGZCGDGvUvOyxOnqpcDq1hd
smyReOaEm8W08RG7KyCWus+rgMztNTaJxDIflNZoUwyETSxM8CPJVPLPyPpmKlTRSYrHsb7/
Alscm5n8MrTlBHgc1dEMsLPPWBvT+TIjEjLrPKAx00BepH5eaPQx/kgdiB8ysugz02fEI2Nk
5fKbQIPhP2pMZZ9WyQWhqEATrIfJvcG7noZ731OhJKHz1fpqeQyzQRWPDNZuWwAAAAAAAA==
--------------ms060204060202090707080307--
