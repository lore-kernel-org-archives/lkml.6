Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqd7z78l4fMxYMz0vTHLreqt4Ij/BB6jDhr3dF8qFlKE/BMRjbqXVKJ3V5yjY1SPJQbFr0Y
ARC-Seal: i=1; a=rsa-sha256; t=1526290493; cv=none;
        d=google.com; s=arc-20160816;
        b=ONwzDc4JIcDr2KgaxT54cyuu/KGPBJ7n+/Z802RF48ZcqrH6hCaCftvTkijbTsAj3N
         2wD++uWMxiGp0tFLdX6FoCrhzKoZP9VwlB3EUN9CfOdgBfLbeGXvJeHFrxXDkxLJKIOm
         0UDSeH4A/y7D+4PPonXfhw4KloSlWo/i0cirauvgaT6WlCiqKPU5unbyX6zixXC3lEFf
         GAYD8Cy/t9d/b1Mowv+VnuC7P6ZizUQlYmlNVujGDFSkhG1w1dlTTLXuXcdc20HnBYDa
         2AjO0UtAemiWJcMdKoFTgLUiZFnx7v+0exsqHO8Q0VMA0bXwba47McRNenVXu1/6z+D2
         xePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=U5r+TdLDEw1WQQpW21FUy2DidGaghbTv1JEDPUvJI6E=;
        b=maldJeym6CvwZvwHTwc37mVamS/i/+MGAaU0vVIyOz8ETEQ2evpWUDDcEYj2HCXK0Z
         PBt7OzRvuZs0+Cd5ReWN6HCiuFcGZIAUFOdLFIaOQ6xiVeZzmz7ySBDxS/V0I0KsSV7T
         D2BHyWSidHom65Omauvx6r1kXMarl9qe0oYNDDb+WArzdbWxt/ubRCDu0JV1otRlf/x2
         Ke/MDoICUgoUOW/1/E/dkVwS07uVNzYIjzp+73mwWMlfpax2qyFTGTlxleEyyUrOTgJv
         dE+MvckL0l4ZJ3EPd+uXMSY5/wXzldtH9RiciKfSXYFeBTDEzmuDhsaLUrXussrwDjdn
         qwmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=anPoaAWX;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=anPoaAWX;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v5 03/13] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
 mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594595644.22949.8473969450800431565.stgit@localhost.localdomain>
 <20180513164738.tufhk5i7bnsxsq4l@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <d8c3a265-f20c-7bf5-23a7-8b80cf25af3d@virtuozzo.com>
Date: Mon, 14 May 2018 12:34:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180513164738.tufhk5i7bnsxsq4l@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:203:69::16) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:JYoJH79XnjWLgGTdvJALFqWL0mJCsKoiSqt+8W25+hh9t4OcUNV57ikAdWHHU28sqHCI58gGr4XZ2mdWTKttODaxM+pru1ZpuT/YCjKhoN74YVb/HsloYFPR311uhW7VdK3dHEubKGc2AaA9/XZ88tn9y4FpEBIMWx73xSW7H4tymCl5wcVA6FnaRIUURLM3znZx+g9fhzxRKNgcy8F1HQXFMpMtTG9n7TCiay8+38u+k3tjoUfUS/olBzRErw/f;25:HzEaM/ItMb63dMzyTA4AONHIotx2z8MawD5I6pY0P1A/G8j+nOwneBRln6CWWItjGUo1XRoRae1lRffN3+zMIeiuASwQbbZVw7b5vr9RVMorQ7TiimGrl6W6MYKCnWgKaScInhNqTC55Wqke6iHTJHGjfR4Aol2p3pmQI1wUrq3AyUDVIMxtm2D43Y695M1OMZKURWNwdjQUydYzWiGmjeJlIS2y68USt3t1j4OqAp6kchnF8F8ySTDnceMPbAyr/b8ZZOyJQEfZXVJPLDGcQwxzdI92AUvII8Nz+eQvoignu4Bg8Jk4K0xPsP4nFEAhY0ERqelqSQ2Knb+0QVlMcg==;31:1k85KGYfuZh5LlcNvZHCv3sSgGBWJ/+op+guFcEzhxF4SS7iXYWhfamrw7Idwr3qWmMJEQOS9GAIcmoCksCEl5ytfE90iXtE7wmnQkJHzaMAqna81CgCNdTE5NtTV7pzGcd3OiaH4APWvNecXhTfIzcYYEI3tET2KdmT761lBUG/n6TKWNLn/5ksFkPPGQEvvPNKMHD+XjPxiPM5k/or9YfGe0036tQ3ZtVD5VE/ruo=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:y2Gfqvxgu/v3PMpa9xHMO2wyeTFaqG/6pfb448pDrAIT0fIwOcfrbE8sDTK8gpipQ6hp9TTahBzdl95lew/xvRBWJgaBGMiv11WaWS1/j2KtLXJRJuqmQ8UCc2DBnyaUiVHjlWNA4uGyClV5WsrcA66ZD3m+7MKPGdraJBaT7SoWLfbJXbEjT8QaUPOv6U73lWytAMV5JcF9An9hGfFay346Wv0TuYRU/mjhxnmopRxKEOYKBJHSmzv3s6MEfEqvM+DBw+wgyn/7D7DRcxPvN9Bx6a/xQeE+OgNOJVLgioyH03qnX9QkC4SF9/mzdVBgsklW2tYeHsz686P1YJJAdpEOwJ1xkAwRmoRz0yMEVJJ44UPbk9Ta0GFX0UFJuW7yH1qjIpG6sHDt4AKtPm4Q3JajaY+1PgCrVcJ4IYYVW352OiBaUvF9oxgCrCZ4ZB2wQbskN97Nzb2JcD6P2ljxaBvaXFsYHOWChH1aC8RALLliFa3hEXL1nrXAvFntxJLb;4:+zKYscq+g0K7C+KvoUy2ZdKM1UEk41r8HqGpxbM/xV8SMwkW3pvpDkTiutHbQfMAx2ohak/2b2MsW0e/NXi02NnTmIn5tkE9BsJ/7YdMvvSUSfjYoIj4BcWdW9jDLZ81KqSP6ksvGDmy1tf9PKSGL2YjFsTs+2IsJgC5wxVXhBV81BWQkI/zP2RFmZE9C3JL5NpQ9FsZJ7ck60sHSRMqEWx77ftItu0F5nX2v4Kqudv+ItnAgTwI0yNXVtWze43JVRQbySbUieHHu0QJ4lY4d47T7EVRfG9i1NcJTYsq9qA4sOMUzz0L8NM8KLM5qSsugEEOM32PPI47O0tSqKRYT8fov41LyJgrXprZl1Lo0zQ=
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338337175BF5A75C247D1CCCD9C0@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(396003)(346002)(39380400002)(376002)(366004)(189003)(199004)(58126008)(68736007)(478600001)(97736004)(36756003)(6246003)(4326008)(2906002)(107886003)(39060400002)(8936002)(53936002)(25786009)(64126003)(8676002)(16576012)(316002)(81156014)(105586002)(81166006)(106356001)(6486002)(31686004)(5660300001)(11346002)(305945005)(76176011)(65826007)(386003)(6916009)(16526019)(77096007)(65806001)(3846002)(31696002)(6116002)(230700001)(7416002)(2486003)(575784001)(86362001)(59450400001)(446003)(66066001)(956004)(52116002)(23676004)(476003)(26005)(486006)(7736002)(229853002)(52146003)(2616005)(50466002)(53546011)(47776003)(65956001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6REZjTGdxTUw5Ky9WY0llZU9CU2FmYVRD?=
 =?utf-8?B?UTgra1J3Y2VQSGIxTkNWWDVUbUU3ZVhjVUh3aXJCT3ZuaXMyYlRZOEZQR3BO?=
 =?utf-8?B?SlFxNlp2VGtVOHRtQXN1ME10Vno2OHdqbnVseUQ5cmVhSmlKR0wrYzhwV2V2?=
 =?utf-8?B?cTdzUmRLekRtbW5pQW8xenhYd2p6cTcwdjM4a0V1cHhxM3dJZ05zZldnVEI5?=
 =?utf-8?B?NDFOWXVRYlJtS2JkMG1rVHVpUkZLSUFSK3NscW1CdXlCK3FDbjdVSnU3QlVJ?=
 =?utf-8?B?eUh4ci9id0tuWkVYOGhZeEE4Wmh1QS9WTk00MFJxWW5jWkZLZVVKR2k0N0tT?=
 =?utf-8?B?TXRqTms4U0hNZ1ppYkkxanJaZHlXa3Exb0FRMFhzYi9SOCtMS2RQa081V3JL?=
 =?utf-8?B?UmFrTlVqbEtGZVY0YlpQd1lsMkkvSzg2MitVcnlBUm1HdlR6RFpvMDdYYW54?=
 =?utf-8?B?UGlSaWFBM3hWc1FnWmhrQkxyRlo1Q3F1Z3A1dkJjRUl2RWpNRzlIV0VDa1Vw?=
 =?utf-8?B?aW1Hb3hPaWlobGdVY2RUcmRVaE4xNHN5STdBQVNVdDIwQ1hWTHg1ZGM0MENI?=
 =?utf-8?B?TWRyYnlJdXZNL2dmcFV4c3BQK3RjT2xrbk9tWG5WREFhQlpvMW5nNWo5OTc4?=
 =?utf-8?B?enBsR3Axc2VQcHgxTisydEtBRjFkVWRQTzRHck15WC9IYkptdFhBRjlJUmVK?=
 =?utf-8?B?dEg1RWVkZ2pIM3R6c3FPTXdPQ2owcjhKdVVhYVNzOTZKOEVjaXprbTJtczll?=
 =?utf-8?B?OVp3U1JWc215cGxGcXcvVStWbytnVTErNTI0bkVaWVJJOXQ3SzBHYmJHYnNU?=
 =?utf-8?B?RzVnR2dPWENUV1JHM2Rpd05KSUE2MTJPelZsNHF3YVRpaFZBWUxDYmw3cWVr?=
 =?utf-8?B?NDVxM0Y4ZENLdmxlMHo2Y3hnbEdPeWpqcVh5QWRPTU9pWXlVSDBHdVdLcjlq?=
 =?utf-8?B?ZEkxY3RIWWM1a0QxWStvMnZVeUY0R0hqTmhtQzhRU2dYdS9IbjEvKzZNU2Rt?=
 =?utf-8?B?Q3lscDFzZ3d0OUdUbXB6eVZBazd5N1hyNk9MMGxjVHVOMUxyaDdKaUpUWE9h?=
 =?utf-8?B?RVFRbmZ5UkZzM1lueVFkbUlWV0tsZmgwb0dRQS9XaFM2L3RxZHVseG9uUXdS?=
 =?utf-8?B?dVhPUnBxUVM0aUVkU2lmMnM4WDM4ZDRTZllzaWF6KzE2UWE4dHdjZnFRdm1n?=
 =?utf-8?B?cXUrbk5Wc0s5KzZnMldMa0l4MXpzYjRYZW51aW0xSnNHRjVPQ1N1aWVMTzQ4?=
 =?utf-8?B?V01jOTdmbHhObzkvOURJQ3M3NGxiamtUVDQwQ1hCWEZxLzVjL1dyMk9KS1Uy?=
 =?utf-8?B?akRYMUQxaTh4QUgzaWtZK1Z3cEpaeEorY2lMTW5LQW9oU2JscE5xK1pZdnhU?=
 =?utf-8?B?QzhzaTBVYjdxelBiRFc0YVFnN2ZwaEM0b2dXd1Z4ZzB3TlhITjRXSzhzMDNj?=
 =?utf-8?B?SWdJR1pGMm1nM0N3azlWckduTVM1R0NDUmRleGM1YkFGb25QaUN2dUphWEM1?=
 =?utf-8?B?SmI5d2ZuUCtEQUwweGNjSjZPSWlDZEI1NWI4Z3VPZEhYN0hkWjhWSnVjWHRJ?=
 =?utf-8?B?YkhUTDFLVmswT3p5TDEwY3NRYWZnbFNLck1GT3VGeGFlUzVDdm04Y284YjRi?=
 =?utf-8?B?Zmk1V0d2L2hhUlVXUTgzVTNoaEZ0ZFlHMi9pR1Q0bXpwamtkQXhtVGRjRDd0?=
 =?utf-8?B?WnVmMmZtazh1UDV0Ym5VZ1JBUU84cDZhNTBoVmFFMnR6WG1FclB4VnY0MFg0?=
 =?utf-8?B?emoxK3ZUOEhzT0dYYWM3cGFQdWlBNDRieWFKNUliVUlubU5vL0NPYTVGT3kr?=
 =?utf-8?B?azU1V0cvblN6eXI2dDI1THM1REZFQTA3RXZOUmZ2ajdlbFlRTTUxRGNKSHVV?=
 =?utf-8?B?WHFNcUVCaDBWN0kwSjE1dE5jMWNZRkFONFpoUmgrZmdKelE4MVBMWk9VWTls?=
 =?utf-8?B?R294clkyNkJjL2FEZFprVTJXZHc3T3EvZ3lqMmIvNEM3Zis1N1U1cHV4eXZE?=
 =?utf-8?B?ZkVuUGNRSXFkSmZSdHdGeVBvQ1RMcmZyeGZJdERRPT0=?=
X-Microsoft-Antispam-Message-Info: pCnvPAFGNgStnUHyc4mNcIiUPiEvZQ/E39tO0iVgw5c6BGJS15NUUaZ2ac81DnNQ8wQFdtjWoBouGn/n7auobJvvi53tDSRs1gBxv6DCVH+TZigsgMeeemi74+x+/zgo0GP75klbWOGMeVhPTkei5YQU/do8ec4pdef5QHKsvdQBE53JcohjJJ9ZuVT690P4
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:eyOj5/Iuquz/zmoHMPccBuUhUu1iY8TaQ87vBhJsXb1LXEdxD+O6f5n5awenUdv2lScMoZHNvKajHzG3cQKsVoatRLUi+370BYO8zkEBtdaTFin6T4VwPbGD7sMmvazYYqe3KmAeYTV8XCp+IK/HfTKtXgi9CQu4KHF00rqdvJyVWFZay0Uxadh8ttNzO8UNFaOG5zmDHL3PCiUIESUOWmYvfxzzpw7mrnxrOsEvHzt0jrn5C0KDHxpdjv+Sdr9o3FYbNVkQBmXwCyyDraH6ec3ADxQ+T8BNZM4ow4vBDi/164rj54PutrnRZkumXHFiErQynFwYeBosF3YaDlOYYBB3wFUJcbykdzOvjy3/0U94kXs+Q99j2HO4mbhXiSUqE3m9ZR7skTddhNlNPyayqjZXUZaPLqswB+vQGoPYfd0hk2MUbM2wo+bgTu2ybycAgDKPXxClus9wpyyty2cYUQ==;5:bjMZZykX6T6fMNlQ6EKzfh/YiVzC33Fs6BaOJuOnDFqnpGWLjwY9oKnOo+TBcNH+96bTL5K/ndAujqpIXnSa3oKe17/UVf+8HR5smuixRtnCDRwbCAE52j9xPj6nM75W7J37T3Wn0uuBsGVL8ZM5TvjoRaP63QJGp69jeReHY2c=;24:hkjNEYEvG+T/5sRyGbIeRheWeQjEqoxFMnE6QbvZKxz6oJlkxACxRiVihloaP9g9ZOqBt0eiwBfPiF1OTmwpK3rz2OLQsYUPhQQEEQUR7eM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:lv5QtSpDpwdYWZ0doa/DO4oA52GvmElsYM39klUm910adoVGgNGvno6qIHXuIqJywDLrykLLFtVm2dI3lAzSaiRlkcFoDAI0UpgO9cBB2SeOzeclVe0P2jixYshqrkqpK6rGJGV5+igYYDw0JThcz3E+IBz6kYgswpsUnnsXn1N33y4gTLvvxp2/6mLg8jcpu8ELtwES6VHeFwjKoESUIDSVrxybgiXp9GTaJbA0jCncKG+OA9H0qztP4MPoLJe2;20:NcDBBo3TaxB7LBDg7PdCPrmXbhXKIVT/5unTPp7MZAMCa9pbMN1JF2Hon8GRiw54fSU5JGlIHEBqb6tJJKv4f3iijr8khzE6LWkZsEv6K5YM2pEaZuuQltrt9h5z0eYQgf46Ja1AVmtet5d7/X6InQWpLI1V21nbJ0WbsYWvu6E=
X-MS-Office365-Filtering-Correlation-Id: 8a1ceb5c-4a5d-4cf7-fa82-08d5b97df058
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 09:34:47.7049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1ceb5c-4a5d-4cf7-fa82-08d5b97df058
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070321367125899?=
X-GMAIL-MSGID: =?utf-8?q?1600431580671985093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13.05.2018 19:47, Vladimir Davydov wrote:
> On Thu, May 10, 2018 at 12:52:36PM +0300, Kirill Tkhai wrote:
>> Imagine a big node with many cpus, memory cgroups and containers.
>> Let we have 200 containers, every container has 10 mounts,
>> and 10 cgroups. All container tasks don't touch foreign
>> containers mounts. If there is intensive pages write,
>> and global reclaim happens, a writing task has to iterate
>> over all memcgs to shrink slab, before it's able to go
>> to shrink_page_list().
>>
>> Iteration over all the memcg slabs is very expensive:
>> the task has to visit 200 * 10 = 2000 shrinkers
>> for every memcg, and since there are 2000 memcgs,
>> the total calls are 2000 * 2000 = 4000000.
>>
>> So, the shrinker makes 4 million do_shrink_slab() calls
>> just to try to isolate SWAP_CLUSTER_MAX pages in one
>> of the actively writing memcg via shrink_page_list().
>> I've observed a node spending almost 100% in kernel,
>> making useless iteration over already shrinked slab.
>>
>> This patch adds bitmap of memcg-aware shrinkers to memcg.
>> The size of the bitmap depends on bitmap_nr_ids, and during
>> memcg life it's maintained to be enough to fit bitmap_nr_ids
>> shrinkers. Every bit in the map is related to corresponding
>> shrinker id.
>>
>> Next patches will maintain set bit only for really charged
>> memcg. This will allow shrink_slab() to increase its
>> performance in significant way. See the last patch for
>> the numbers.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/memcontrol.h |   21 ++++++++
>>  mm/memcontrol.c            |  116 ++++++++++++++++++++++++++++++++++++++++++++
>>  mm/vmscan.c                |   16 ++++++
>>  3 files changed, 152 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 6cbea2f25a87..e5e7e0fc7158 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -105,6 +105,17 @@ struct lruvec_stat {
>>  	long count[NR_VM_NODE_STAT_ITEMS];
>>  };
>>  
>> +#ifdef CONFIG_MEMCG_SHRINKER
>> +/*
>> + * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
>> + * which have elements charged to this memcg.
>> + */
>> +struct memcg_shrinker_map {
>> +	struct rcu_head rcu;
>> +	unsigned long map[0];
>> +};
>> +#endif /* CONFIG_MEMCG_SHRINKER */
>> +
> 
> AFAIR we don't normally ifdef structure definitions.
> 
>>  /*
>>   * per-zone information in memory controller.
>>   */
>> @@ -118,6 +129,9 @@ struct mem_cgroup_per_node {
>>  
>>  	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
>>  
>> +#ifdef CONFIG_MEMCG_SHRINKER
>> +	struct memcg_shrinker_map __rcu	*shrinker_map;
>> +#endif
>>  	struct rb_node		tree_node;	/* RB tree node */
>>  	unsigned long		usage_in_excess;/* Set to the value by which */
>>  						/* the soft limit is exceeded*/
>> @@ -1255,4 +1269,11 @@ static inline void memcg_put_cache_ids(void)
>>  
>>  #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
>>  
>> +#ifdef CONFIG_MEMCG_SHRINKER
> 
>> +#define MEMCG_SHRINKER_MAP(memcg, nid) (memcg->nodeinfo[nid]->shrinker_map)
> 
> I don't really like this helper macro. Accessing shrinker_map directly
> looks cleaner IMO.
> 
>> +
>> +extern int memcg_shrinker_nr_max;
> 
> As I've mentioned before, the capacity of shrinker map should be a
> private business of memcontrol.c IMHO. We shouldn't use it in vmscan.c
> as max shrinker id, instead we should introduce another variable for
> this, private to vmscan.c.
> 
>> +extern int memcg_expand_shrinker_maps(int old_id, int id);
> 
> ... Then this function would take just one argument, max id, and would
> update shrinker_map capacity if necessary in memcontrol.c under the
> corresponding mutex, which would look much more readable IMHO as all
> shrinker_map related manipulations would be isolated in memcontrol.c.
> 
>> +#endif /* CONFIG_MEMCG_SHRINKER */
>> +
>>  #endif /* _LINUX_MEMCONTROL_H */
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 3df3efa7ff40..18e0fdf302a9 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -322,6 +322,116 @@ struct workqueue_struct *memcg_kmem_cache_wq;
>>  
>>  #endif /* !CONFIG_SLOB */
>>  
>> +#ifdef CONFIG_MEMCG_SHRINKER
>> +int memcg_shrinker_nr_max;
> 
> memcg_shrinker_map_capacity, may be?
> 
>> +static DEFINE_MUTEX(shrinkers_nr_max_mutex);
> 
> memcg_shrinker_map_mutex?
> 
>> +
>> +static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
>> +{
>> +	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
>> +}
>> +
>> +static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>> +					 int size, int old_size)
> 
> If you followed my advice and made the shrinker_map_capacity private to
> memcontrol.c, you wouldn't need to pass old_size here either, just max
> shrinker id.
> 
>> +{
>> +	struct memcg_shrinker_map *new, *old;
>> +	int nid;
>> +
>> +	lockdep_assert_held(&shrinkers_nr_max_mutex);
>> +
>> +	for_each_node(nid) {
>> +		old = rcu_dereference_protected(MEMCG_SHRINKER_MAP(memcg, nid), true);
>> +		/* Not yet online memcg */
>> +		if (old_size && !old)
>> +			return 0;
>> +
>> +		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
>> +		if (!new)
>> +			return -ENOMEM;
>> +
>> +		/* Set all old bits, clear all new bits */
>> +		memset(new->map, (int)0xff, old_size);
>> +		memset((void *)new->map + old_size, 0, size - old_size);
>> +
>> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
>> +		if (old)
>> +			call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
>> +{
>> +	struct mem_cgroup_per_node *pn;
>> +	struct memcg_shrinker_map *map;
>> +	int nid;
>> +
>> +	if (memcg == root_mem_cgroup)
>> +		return;
> 
> Nit: there's mem_cgroup_is_root() helper.
> 
>> +
>> +	mutex_lock(&shrinkers_nr_max_mutex);
> 
> Why do you need to take the mutex here? You don't access shrinker map
> capacity here AFAICS.

Allocation of shrinkers map is in css_online() now, and this wants its pay.
memcg_expand_one_shrinker_map() must be able to differ mem cgroups with
allocated maps, mem cgroups with not allocated maps, and mem cgroups with
failed/failing css_online. So, the mutex is used for synchronization with
expanding. See "old_size && !old" check in memcg_expand_one_shrinker_map().

>> +	for_each_node(nid) {
>> +		pn = mem_cgroup_nodeinfo(memcg, nid);
>> +		map = rcu_dereference_protected(pn->shrinker_map, true);
>> +		if (map)
>> +			call_rcu(&map->rcu, memcg_free_shrinker_map_rcu);
>> +		rcu_assign_pointer(pn->shrinker_map, NULL);
>> +	}
>> +	mutex_unlock(&shrinkers_nr_max_mutex);
>> +}
>> +
>> +static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>> +{
>> +	int ret, size = memcg_shrinker_nr_max/BITS_PER_BYTE;
>> +
>> +	if (memcg == root_mem_cgroup)
>> +		return 0;
> 
> Nit: mem_cgroup_is_root().
> 
>> +
>> +	mutex_lock(&shrinkers_nr_max_mutex);
> 
>> +	ret = memcg_expand_one_shrinker_map(memcg, size, 0);
> 
> I don't think it's worth reusing the function designed for reallocating
> shrinker maps for initial allocation. Please just fold the code here -
> it will make both 'alloc' and 'expand' easier to follow IMHO.

These function will have 80% code the same. What are the reasons to duplicate
the same functionality? Two functions are more difficult for support, and
everywhere in kernel we try to avoid this IMHO.
>> +	mutex_unlock(&shrinkers_nr_max_mutex);
>> +
>> +	if (ret)
>> +		memcg_free_shrinker_maps(memcg);
>> +
>> +	return ret;
>> +}
>> +
> 
>> +static struct idr mem_cgroup_idr;
> 
> Stray change.
> 
>> +
>> +int memcg_expand_shrinker_maps(int old_nr, int nr)
>> +{
>> +	int size, old_size, ret = 0;
>> +	struct mem_cgroup *memcg;
>> +
>> +	old_size = old_nr / BITS_PER_BYTE;
>> +	size = nr / BITS_PER_BYTE;
>> +
>> +	mutex_lock(&shrinkers_nr_max_mutex);
>> +
> 
>> +	if (!root_mem_cgroup)
>> +		goto unlock;
> 
> This wants a comment.

Which comment does this want? "root_mem_cgroup is not initialized, so it does not have child mem cgroups"?

>> +
>> +	for_each_mem_cgroup(memcg) {
>> +		if (memcg == root_mem_cgroup)
> 
> Nit: mem_cgroup_is_root().
> 
>> +			continue;
>> +		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
>> +		if (ret)
>> +			goto unlock;
>> +	}
>> +unlock:
>> +	mutex_unlock(&shrinkers_nr_max_mutex);
>> +	return ret;
>> +}
>> +#else /* CONFIG_MEMCG_SHRINKER */
>> +static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>> +{
>> +	return 0;
>> +}
>> +static void memcg_free_shrinker_maps(struct mem_cgroup *memcg) { }
>> +#endif /* CONFIG_MEMCG_SHRINKER */
>> +
>>  /**
>>   * mem_cgroup_css_from_page - css of the memcg associated with a page
>>   * @page: page of interest
>> @@ -4471,6 +4581,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>>  {
>>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>>  
>> +	if (memcg_alloc_shrinker_maps(memcg)) {
>> +		mem_cgroup_id_remove(memcg);
>> +		return -ENOMEM;
>> +	}
>> +
>>  	/* Online state pins memcg ID, memcg ID pins CSS */
>>  	atomic_set(&memcg->id.ref, 1);
>>  	css_get(css);
>> @@ -4522,6 +4637,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>>  	vmpressure_cleanup(&memcg->vmpressure);
>>  	cancel_work_sync(&memcg->high_work);
>>  	mem_cgroup_remove_from_trees(memcg);
>> +	memcg_free_shrinker_maps(memcg);
>>  	memcg_free_kmem(memcg);
>>  	mem_cgroup_free(memcg);
>>  }
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index d691beac1048..d8a2870710e0 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -174,12 +174,26 @@ static DEFINE_IDR(shrinker_idr);
>>  
>>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>>  {
>> -	int id, ret;
>> +	int id, nr, ret;
>>  
>>  	down_write(&shrinker_rwsem);
>>  	ret = id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>>  	if (ret < 0)
>>  		goto unlock;
>> +
>> +	if (id >= memcg_shrinker_nr_max) {
>> +		nr = memcg_shrinker_nr_max * 2;
>> +		if (nr == 0)
>> +			nr = BITS_PER_BYTE;
>> +		BUG_ON(id >= nr);
> 
> The logic defining shrinker map capacity growth should be private to
> memcontrol.c IMHO.
> 
>> +
>> +		if (memcg_expand_shrinker_maps(memcg_shrinker_nr_max, nr)) {
>> +			idr_remove(&shrinker_idr, id);
>> +			goto unlock;
>> +		}
>> +		memcg_shrinker_nr_max = nr;
>> +	}
>> +
>>  	shrinker->id = id;
>>  	ret = 0;
>>  unlock:
>>
