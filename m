Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx49421kjs3xULEvPtAITj05vGNXWlUvw8Fv9NnZg5I+TCgzcBkZMPy14EQYvFq2eIi7SZv+T
ARC-Seal: i=1; a=rsa-sha256; t=1523974295; cv=none;
        d=google.com; s=arc-20160816;
        b=UgVdyjTO4habyqwq9WX8jhq6nBvGX35ZwVyVtOcj7yi/yaZAr2/PwM95nCBXSjN338
         rebh/Sjkh+1dnsFcuvr6S0ReWlSM/qW2f1yoK/wL6WfjKBIBTwaRkAdOCh0uAFOeXSNn
         rwoNkyYCTziT3p3fpWZ26Mx9NdyiiQTheqmcHM9cT8Fe7efoq7RzKVxXTinGNlpiyEQN
         R1vBkmWhUmsAWjSEx94tibDoavxOLXLzxyovw3xcqsKbcpsqTTY/73s8mzV9hmO+YwY+
         NIQUflnA9wSecjaZ0xMWXZE/HLsQGkkZhqHSaOYv9W57P75hIZocA5bVb9N20/cVDHky
         2NOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=pkli9gepsiqfYNXoIKujwbPeusQL8bhCRVCuWVtcYxA=;
        b=0L0GLIpG2jPG0Zf0UvWZ2GZ6mBG4d8TlLMYW/jLyGc0FW5fyghz1hkMYiJnrd9Q3ud
         HeLXspn5msAlpIqNuu2sfJWBelQabdJpYNFw72V9hI+ywNDZnwLgQPcaBjWH2O+BFQIP
         n3lcVDYzFJnc6e7j9HDHEZ+issfF+6Ju7pq8X5IbjFV1jiU3Oo7LPNQUEUvd9jsrHBq4
         iw9dM22m+Q/EWH7FyX3N37OVNPGj7qWMzz8FgnCNUTtComgc+Zw1l36jZH3RpjSYIdZs
         HYqYe2b84jE3isbEPHyTBOYiTuv7Q99++f0JaL/oSV3zIiK/MC4DVS4xSY1qvx92lkAK
         qBng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=ZB6gQa3m;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.105 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=ZB6gQa3m;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.105 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2] usb: chipidea: Hook into mux framework to toggle usb
 switch
To: Yossi Mansharoff <yossim@codeaurora.org>, Peter Chen
 <Peter.Chen@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:CHIPIDEA USB HIGH SPEED DUAL ROLE CONTROLLER"
 <linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: robh@kernel.org, swboyd@chromium.org, devicetree@vger.kernel.org,
 Stephen Boyd <stephen.boyd@linaro.org>
References: <1523973148-2094-1-git-send-email-yossim@codeaurora.org>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ec1c44d7-45a8-a27e-5c45-717b87d3b252@axentia.se>
Date: Tue, 17 Apr 2018 16:11:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523973148-2094-1-git-send-email-yossim@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0130.eurprd05.prod.outlook.com
 (2603:10a6:7:28::17) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:rsR5EsNzNmYFfgyjRfzAZm0SKq6Z76yu+EKDRkM6AVKfACX+p6EOSlJNHgGN9UeEeBB1wXO6+EfBgrmhdyymRkaSWy4iG/UQ8IXEzlNnrb+uLba/vX/szAFUxc7PTZtQW/18FG+RDRiOL6I/ISgSBo0NaA/XrnHP3XmQkMxv5pDVQWUuPhY9As2/3y9EV1sd55EMfXyUIPrdyPhvuU48r8A6b3tndXvgBplb63PnjIgp2GExZ6AuMibUOJvIfJx/;25:tMgpkp9NPB3qg5+StlJHIpxcVLq56+1+US2ID4hBAsB4Z7FdlIsxCWpP0XAUoc0Sbv89Spd4eIl7qzuuZodsW1d5PLBCYDgTCKeYH+tpWTLA0ijDkFEc91aW/fC6EtVAUAUbBud5+DxaMHLnEM9FzWEhek8JTdgl//eBti9of+8JbBf+NifMcD9TksoJCpmcikYEBoZOhXnbl8SJP+WyQvn2EvJrjDWznr+RKI8dqyvBqhhieOvxEkZ4mWwM3fXjIfraAvhi1HfUDwXFym2YROc91qLPsH9bYE/VTrSzAe98aNYWbEgOFeT7HuMWJyDeD4VGDu4etE0AN7VDTMmr2g==;31:7L4UK9dahL36takQckyMSkCLnZzO6r98iNx8XMjiHQyUN5rNyYKT8pBy0asKiGUMJ7RfXxENOygRR9OnhuIU39+eruPma3ZX0/Ey+0hBBMuvS2rvXCc9nPmi/h8VONKB94Oxgc2qCex/5APs8UKdD+HnQwreoteTSG5MN4/mv87h2XB7eieIHMTdKdG/ACn85mykFBO786mdgHtonisrW6z+7p9We6XHbOEvDBiEmPI=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277757FBF5CC8C64F77B5C7BBCB70@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:ekf4ERmV7S9EttosuZSOZF4tUofI3ztiCpimq69juqj6DmB/j09FBBM6fIY3X2Nkv49lEU1w/JhcLigLBxTgLqlNKrTdAKiJjJmlhMNQ68Ex6DI/FL7SB0PUkVwoXyP9CLd00+Y+ZPKa+MVjkTzkXS2zl4nczzch2RBEkvNN99Ez5x2bqg07uJodH1aAmgWrJ7lPJTRGPeJg6Iw/+9aHy24uoZee0fWRBH5TJ8STy6/b2H1L/dGvWT0wSo1df6NYH+28gms8steXuntOXJTIQAfhnpU4+HQi3Q0ZHO8+liUqHc9KdBGZLtUFuGpKCw9R
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(39380400002)(39830400003)(396003)(376002)(377424004)(199004)(189003)(77096007)(476003)(446003)(3846002)(117156002)(230700001)(53546011)(6116002)(3260700006)(6246003)(65826007)(2906002)(31696002)(956004)(2616005)(36756003)(110136005)(8656006)(86362001)(68736007)(5660300001)(25786009)(6306002)(11346002)(26005)(66066001)(65956001)(52146003)(36916002)(16576012)(47776003)(2486003)(52116002)(105586002)(8936002)(106356001)(81166006)(8676002)(58126008)(16526019)(186003)(53936002)(4326008)(6486002)(316002)(6666003)(23676004)(64126003)(81156014)(76176011)(229853002)(74482002)(966005)(486006)(305945005)(50466002)(7736002)(31686004)(97736004)(386003)(478600001)(65806001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzc7MjM6cFYwVFdZWGVLU3cwVmtaMEpCQUtVN3NY?=
 =?utf-8?B?dzFESThTb1krOVVuaUQ2TjcwRVd0KzROeUoxOUV0dUNQcDloVDNQeFlkelFS?=
 =?utf-8?B?aVNxSDlGbEU1cGNyVFhPcGhoQzRtRDROK1BFcmhRTHhIZ3AvTmpBODVuM080?=
 =?utf-8?B?aGFEZGk2Mm41elpSQjIxbjU5djlmaUVWT3FwSEtKSElHNzRvREJ0WUREdG16?=
 =?utf-8?B?NkJOZTc0MDFjbEc1Ulc5OEJTbVdpK2krdlJ3Y1VKRVFVRWoyb21wMzkrV1ps?=
 =?utf-8?B?S2s0YkU3eXpUaW9kRkNySm9rbVFrRS80L0QybnFjME9aTGpYbTh6NE5qa3Fq?=
 =?utf-8?B?bGlGeHgyOVZiK21QT3Qvbk5PVXh3S1BsRmoyUytvb3NEdGZrTGRUVkpnc0JJ?=
 =?utf-8?B?aUkwYlI0VVFYR0s4VDZWdmcwc3ozYmxka2c5aE1wc01pM2x4WnV5KzBRR0dJ?=
 =?utf-8?B?QlNmemI3OWk5NEVqY1pndkhmNy8xYUxFODZ1Wk9sVTNMeFFTcjErSG9xNk5U?=
 =?utf-8?B?QUxCZ3ZnUVU5ajZVVnQvL1hkcWZBUEQ5TTNXTUprU1pCdVFMK2dlY2IzaStI?=
 =?utf-8?B?QXdLengxZm5ENWhhUHg3My9BdVFnelFjMERYeWJVdklHWDlKRXZhYkZvTXQ4?=
 =?utf-8?B?NXRraEZadDNsbFBMaVduZm9SR3VHeWgrby9nckMzUE16b3FkS3dHZW0wR3dx?=
 =?utf-8?B?dVhiY1ZSOGRYdFF6bFhiQUdJUVVJeXNrc3NKRVJOajdPMzZMSVJjSm4wSFBS?=
 =?utf-8?B?cnl1K2FvVXdIYkRGWU1rY3lFdG9WY21seXExb1dmcU1uK1cvZFFzOUVuR0NQ?=
 =?utf-8?B?Z2ZkUDBidEhFZDluWk9WQUJIMUlYd1hIYkZDY3NOZlpLVkVtV29tZXZjMEdE?=
 =?utf-8?B?ZU5DWUFWRktROExUODZqUFIvSlQ0ZGFGQTdDQ0hISVNCb3JUT1JHUURJdG9m?=
 =?utf-8?B?RGYxamZFZWEyNWYxbldkNGhjdUtBV2RCNDNvM2w5YVVXS3BaS3pab25QQjJo?=
 =?utf-8?B?UGhKb3JqQ3l5NFQ4cVowY2dZNWl5WmRvSGNaZTQxa2dDQXJjMUozaWhHNXAx?=
 =?utf-8?B?WWhPaHpTYTdxZnY5WE5ucFpPRmpSNUQ0emFYYnIzeFdXcXlJem5BYTVuV2U3?=
 =?utf-8?B?T2ZhbkpOSTZlSVo0aTA1SnZWQnNaK1k3K1AxV1ZVbFE2eGpqRzdjWUExeGxk?=
 =?utf-8?B?SXFtRmUxalBKZGdVYnRlbmhMbWlnSnVHVUQxeGNuQlVtbGloTDVHaHZpWHBj?=
 =?utf-8?B?YWVaVG1IU2JVTUs0L1hTeHBJZU5Oa210NFFGYzdGZGp2Qmp4U0lpOVBiejNP?=
 =?utf-8?B?NkEzVFdBS1VCODlMZWFWcWpjRkd5NUNNUnZtbm1tOWpCdVJTQWhnalU4ck1F?=
 =?utf-8?B?SGtFVlVpUFJ2bkNScEFxNGk1bnEraHpocm01cDA4SGFxVnRzUE55TXU3WTda?=
 =?utf-8?B?SlNtQ04vYzlUVEZNVWQ3Y3EvUlZFVm4reHlYbElaelpUVXNYZmJES1lMTXIy?=
 =?utf-8?B?QUJkNXhiUlN2SXlsaTNJbHVDZS9jRmQ1K1VjV1pYelhKekdnZGJpSnNrOTdQ?=
 =?utf-8?B?aEFPNmhFQks2Yms5dkgzOWMrdUh4blFhV2dOSm9WNERvbkhIMGkvNnJSbHlC?=
 =?utf-8?B?bHJYMnFiMFFzWjFnc0pnQ2hxYTFRVGRkWXNjS2k4MGJqUmY2WUEzMHVlKzlq?=
 =?utf-8?B?c0RNYmVzZUJKbkJnczYybVh3eDl4NU9IV2lYcGdpWWhHUU11YTQ4cTBCd2gy?=
 =?utf-8?B?eUYxN3ZvdTdwQkg4WEJkZm5hS2hJL0lrUXpzSTdJWmpGSjZMZUxOenMybzlj?=
 =?utf-8?B?ekpjVlRFL3VPZkI4SWdLUFNHallrekVVbEptYTdwbE9aWkFualFEOWU4UHVH?=
 =?utf-8?B?T2xjNmRxdGZoVGd0OVVkcXFVM3hUWURJeS9HVlVRT1ZSZndnMHhuSEtWVCsr?=
 =?utf-8?B?NkhKazFIcGJ3TTBIUC9tN1dKTFRKM0JqZXJ5ZXhmSUovVDBvY3V2OGdiUjQr?=
 =?utf-8?B?L3VXMVduMXJSdTVzNEY2a3dpZHU1V0txeUVFRXlNcVZ4TVJqc1JlRCttUWp2?=
 =?utf-8?B?c0NBWGRxM1hRbWV1T250WVAyMi95dHo4RWwvN0JmTGxsanMwYjNvU1YvWGs5?=
 =?utf-8?Q?p1Rl8osJoCyZN64GBGii1d2gJ4OPLYP2rXiX/HzdYvnQ0h?=
X-Microsoft-Antispam-Message-Info: /W+hEMONdyjXcSvdjVZ0gW1C+E7wqHdZjlKvN/HmigVcgedUROj2dlulpIf4sFgkpdH4AdDNu9slmMVNo/1y03EIo2rAqq0w3JiiGT6pvS0bAxAI4aRrwYrqKMXPcqx6urUdWi5EWV/x5r2kWsAQWlGUcGt5oIAxc0pZ0+JVif8rLKYWceHTVNhpkE7Fxm4c
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:zqRDiD64YLFjffgh6XUuxz/GlQiKjmFwk/zSbwM2GcmlG7/N2sGFleWggcPcpQfe9cis4KpchL4QUtgQST1KoRZvyPU+eaId9sguKxJApLtUHbeiaFjB9NBAA37PqSxxDtEtUShb2rvu9UFWVXRyJhL0Og1xH2fiVNVsZRFezLalOB3AQOvfjA8VeXQtaz8sTPZ29IeVt8N/9mYEIKU1x4/3ppQUeBYZMZ3r4YdzsVcrecBZPzPzfu+OcWs7J/HnzKbpyKclrIIztGXpUbyxwjBYqBJhJsbdWAP0Liu3VJvVZHkqBzBzX7ndb+JUD1dBwbskFIh2PxjJJqWxXORA1vdx2tnGl5KbwD8W1+c+x633XoHJn1idZY8Sk4i7rLf69mSQTW+ZIQwywNp3IM1zkVhiC53L4EVchQs7hjESREtEjCcsu1vP6kQm28akUUuiK/pR6J29c2695/bZ7BVWyA==;5:YqbzNHiCe4jCnzkmIKO6sICbJeq2WowvWsaYGC1v3b+5bGkARwLNHNO7u1xBwxmB453R98G5tr3mHmp5Ri8VUMq68R6puNobV9pW4/SoBL0y9aXPKV0jR0RDW/6CVs3cvX1IDOe70IklcQp7tZQFVRlTmp/eSl2VkVX5Z2nwdGo=;24:nwypbhp0SFffzVX89eVw3Qj+K92YM20Wb+WYJVS8WDU8/vZhXFq6egsZXZx44Pxa01ho8MHv2FppqtlAiA9PlJGm4zU1+19+sBhlXBMVxsc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:A7yqjyv77++CLKeeqiAt/myRWlFaiJ/mqjYO7ntzfYcVyZAp7dC/GUdtwrqno7xjP5GNWom8XQjXk62j/KReQlzvxh4rrJPQXKejDlV/T2bJUjTZeZuVdt8mLFQRokPQ0u96qC+8nxaNpXox3MVpH0641v1Mn4gIYPSs8pzIig9Q1f6ZVpwbvtiPevA13xdkFlnlaN7JBIAPexRbOhLu6hss0OoxnrtNnifdnPc8BXwzOfXz9zQwW2td7JQG6UIw
X-MS-Office365-Filtering-Correlation-Id: b4a86131-1b6b-4d66-52a9-08d5a46d1db3
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 14:11:29.6818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a86131-1b6b-4d66-52a9-08d5a46d1db3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592995743032653066?=
X-GMAIL-MSGID: =?utf-8?q?1598002870863198665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-17 15:52, Yossi Mansharoff wrote:
> On the db410c 96boards platform we have a TC7USB40MU on the board
> to mux the D+/D- lines coming from the controller between a micro
> usb "device" port and a USB hub for "host" roles[1]. During a
> role switch, we need to toggle this mux to forward the D+/D-
> lines to either the port or the hub. Add the necessary code to do
> the role switch in chipidea core via the generic mux framework.
> Board configurations like on db410c are expected to change roles
> via the sysfs API described in
> Documentation/ABI/testing/sysfs-platform-chipidea-usb2.

Ok, so this is v2. Please describe what is different from v1.
I have told you before that this information helps.

> [1] https://github.com/96boards/documentation/raw/master/ConsumerEdition/DragonBoard-410c/HardwareDocs/Schematics_DragonBoard.pdf

This link returns 404 for me.

Cheers,
Peter
