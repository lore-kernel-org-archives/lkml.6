Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeBZJ7g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:59:36 -0500
Received: from mail-db5eur01on0128.outbound.protection.outlook.com ([104.47.2.128]:24672
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752445AbeBZJ7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:59:32 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [tip:x86/mm] x86/mm: Consider effective protection attributes in
 W+X check
To: jpoimboe@redhat.com, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, jgross@suse.com,
        peterz@infradead.org, bp@alien8.de, mingo@kernel.org,
        brgerst@gmail.com, boris.ostrovsky@oracle.com, jbeulich@suse.com,
        dvyukov@google.com, hpa@zytor.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
References: <5A8FDE8902000078001AABBB@prv-mh.provo.novell.com>
 <tip-672c0ae09b33a11d8f31fc61526632e96301164c@git.kernel.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <cd48304c-4317-6b5a-bde3-113645df8f81@virtuozzo.com>
Date: Mon, 26 Feb 2018 13:00:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <tip-672c0ae09b33a11d8f31fc61526632e96301164c@git.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR06CA0140.eurprd06.prod.outlook.com
 (2603:10a6:7:16::27) To VI1PR08MB2832.eurprd08.prod.outlook.com
 (2603:10a6:802:25::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9004479a-60ce-4d2a-05d3-08d57cffa09a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR08MB2832;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2832;3:Jic4SXzIVnkPxYcX015e+vPG9Xlf/cNE787guCcGrPYTGvBX2JeHBzGt+mibvzNwlBDMSroZkDqZjD4/ie0sJNJGoNigGoq2FilqW2nAt+aSaQHC8mkY2m+qK8CYdNHVrvyx9ZyPFepV+q/FQFSdi6ICeY2Px2LukTMeCIy8MNqh1LOMWCwMNfo9DxrwDCFme7E+N12G2Hev13v7TdQB+fUKb4Y8rrSLa0IPX8zQio1UOtg3ZZjwT7+6vrVI0I/W;25:z4Br6Uah3Sbor0XCSZXkJTyGs+MbzSaONE/TqmPVERWpL7BaKx/vHpU2Q3twHSMSbpNpnzeEdX4MiWuhjeLAfMxV8pd3J6heM78HvxOO6yT6+cXxJ9+rRrXl+BMpQv8WA4xNiCW8G94IO6m55Sc6nco1QqG4Ol+4Cx3EGQxofAKDIoO48xh1FxiPYubighABvlWBCKV0FU5W7oG3cZVs8IWKz8I7Fi8QSrJU44gLrKJ0mcDltsUlrMEcifQ1807jsfPI4Ic19JExMExIkHSE5mfJDrQHJjbkkUa6ZfGtnhBwckhZ3F7n2MBD4aj+pTZzV0qc76ZvgBd68EoZi2im7A==;31:RuIKpPyLR4n3o3HHm6vTwfS64xtXmgCOsy5FNEXMGJk3gLqC2hk+Y3miw4yX4WeCz9w3oqs6y+GaY4teNQWKvY3X40nrwuVV1fQplSkS6K6ZG0Mxuvl0vGLv+VviLZmX35L4dQ4eQ2Nh/mu37l8fTiqlE8f1qmfFkVqPs2R7gcLFQt+WsiT7OG5CvzZ2tVM7QtTta9FCg717QKrn+2qh/yKrR26mSEuzeAULXg7E3pc=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2832:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2832;20:oY14dwOk6J1eTe7GvfEL6HN7Vjj1OHTfiZh8+ATtiRO5/dbNGCqYs9m9YndIAqYd4ThKZh8WON5vb8pQzM4dOWxYoHscrwDyDMaGh3RA4aE5GsImKPYnCDPto/KgJ1VcnlkLSTtoP1fa59JBOXGpYxp5pNd5vU1nzSENRCEUWfAJ9F+KABPi7bmxUg3gzRVlkHEtdqt1x4AXBGkmrBS743A69lwAv3pzstbTnZ6GLkTMD+G3eUbt5bCl0A6M4vwlDQrUU/ZMQrJo3JiReGVdxi/IVcliwwNaBE3XLqlJlybWTy9QyePBrkhgT4732MRCI9ihKZnC87tYTVfjQHM7jcNMQ03yxMModQaL70ODjmgpXqlI64lhym6/w11ULgllq7uN5j8oIbdMAFWSAF2EjmY61GNrt3lAzQjqopLmYLVtytPBB2yu4OwTTz4xmGTUHwwwFEVQX5LEi6tcjanZ40OWP49tn4xM7cVHcnbmuIXxq2oua0CD595blvn5Gh/o;4:gM2UI5d0bOiJPjGPrLt465umu9YLJRKZYzx3nBVMY2ns4ssVtoVZxRk8QcGXLAbzX2juCX+0XnT+mgXk4UkQwM2R948FqUqWAFNWHITTo6Pqz0Id2Rs6ilyoYlt8sWz6NHoRkLoCAvuuhnbNvelJqmkcEtMkeBCDK+dklQG7UDxT8Wqrj+ly6BkWR++SEYto6I9DCGNev9HlY7zPy9XEH5VL4ezQTUmXbfiUN+2P0jpO/QDeYcOUfda3szcBzqlKJOXq46LGFe2SocQRUemKOA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB2832885A806895F04DC0D87EB0C10@VI1PR08MB2832.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501161)(52105095)(10201501046)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR08MB2832;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2832;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(39840400004)(346002)(366004)(376002)(396003)(189003)(199004)(97736004)(31686004)(8936002)(305945005)(31696002)(16576012)(81166006)(86362001)(81156014)(7736002)(6666003)(68736007)(2950100002)(316002)(8676002)(2906002)(65826007)(105586002)(36756003)(106356001)(58126008)(6116002)(3846002)(77096007)(229853002)(26005)(47776003)(186003)(16526019)(7416002)(55236004)(39060400002)(53546011)(386003)(50466002)(5660300001)(230700001)(6486002)(64126003)(6246003)(53936002)(478600001)(76176011)(52146003)(23676004)(2486003)(52116002)(25786009)(66066001)(65956001)(65806001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2832;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIyODMyOzIzOmFLalpYSFVWd3FibjRYVDgrU1Q0dVZNTnVW?=
 =?utf-8?B?V1RVclRncjB5VitvZE95d21Ma0hPSU94bkkrSXRRcVhRVVYxSUw3dFZhM011?=
 =?utf-8?B?N244eHJBcVY3UUtiN0ZzSmVBODkwUWNNbGxHbUM3UnJlZHoyVTdPTEgwUjJC?=
 =?utf-8?B?QTFncG5Dek0rZjlUOEkxUnZKQlVPa3lKTm5Td2Y4RTVMWHZrUm5YRGU5SFAx?=
 =?utf-8?B?WldGTHJwL2c0WSsrWkk2REZGY3ZGVHQ1aXp5S0JwU3VxWjNsbzc3TGZCYkMy?=
 =?utf-8?B?enEvOGs4eUJHRThEMWdDR3RqY0lOeXp2Ym51VGhzRTErRC8zSlFiRlIrQ0Y4?=
 =?utf-8?B?NGUrWVUrQ1dIbEVvQ21hSi84ajk1VHNrTy84K0lzR0ovaWlRcWxWNTlFNFRR?=
 =?utf-8?B?TklUUUltdVh3Nk5NSGVJL3Q4Ykx4czdBdWw5VVpRM2M4eE1ac0o3WGRheVFk?=
 =?utf-8?B?NVZhVEVVb1lYUXJ1VjhoY29CWjRMWE5YOFZlYURITXhmUGthQ1UwSm1VYXVu?=
 =?utf-8?B?ajRIbWd2VTZ1R01lYnVFY3ViQ2ZjZ0E0ZjNBaThMNExxOUd5QnRuUCtreUNo?=
 =?utf-8?B?MjRUL3NjTngrdzFzejdsTUJlUkMyeERuZXl3QVpWbEcyd3RiR05JMlIveXla?=
 =?utf-8?B?ZXpOajNWTEhNcnBzeW1KWGo2K1JIUjdkV2ZEQUpwWkpSUlVqL1lqRGtFR0lO?=
 =?utf-8?B?OUxLQnBkM3ZYcmlsdDJYL0QvdzB1YTdSMVh6QzBESlYzUVNpVUF5ZWRFT1Q3?=
 =?utf-8?B?YVFmdjJGcnVrdks2S2xFRWF4ZTlUU0JzRVJtN1dwemlMQnZvMHpOQ3ZsWjJs?=
 =?utf-8?B?SUlHZm9PQitkLy9FenJsRm1TS1QxVlkyVU5iU2k0VVZmTjBUWnhSQWMySHlB?=
 =?utf-8?B?MjVKbUVJRlJNUzlrcVhDeThnN21vajhoRFphbkRURWVadVFZZTFQMmEwclp5?=
 =?utf-8?B?R0phWTF1TEdxbHZwUHpvL3BybUloSTlDWm9ySmFhNHdvTEFaWm1EMHQ4dmhq?=
 =?utf-8?B?OGpaZjgzTnZtOXk5LzNXZlMrZnB4L01VNEQrSW0yaGVkbE1GWnJuWDF3ZDBn?=
 =?utf-8?B?YVNuTnkwU29hN21zRFJHR3VkRExVV1ZsSWhTMGprUWh4L2lvaDNJZ2c1a1Rq?=
 =?utf-8?B?dEdZdWVtM21rcklpUVp1NitzUk5IUkdDMWZJeUIyNDBqZjNkZnlpTk1BUXpK?=
 =?utf-8?B?dTBlNmxpY0trcFhZQS9Pb0J1dVhicjFqV01mTnFqeHh6aGIvM3E5SFR6RURR?=
 =?utf-8?B?bVQwUUZiZTJHZTR5emYvdFM4L0ptbWpLSjRtQkdiYVZOME1LSGl0ZDk1VmJz?=
 =?utf-8?B?QzR0OTRTWVY2a0p2N0FFY2paS0duSHNhMDFuQlI4NzM3cEtmRUd6ZFcvZVZs?=
 =?utf-8?B?bnE0ZUxKNWJKRlhyaVB6dkhmQUs0TnZtdDd0MXNyZHEvWElaVzdiT1ZWRUk0?=
 =?utf-8?B?Z2ZCcDlKbUw0M0djL2pndkdVa2VUelBKdDlXWXFTTDBnc2M2NVNRamhjRFVv?=
 =?utf-8?B?Q1dRL2xEclhsS0RwbXVMbElWYjlkeUwxczhnaFZkT2VqMGFFSXgxZGxOMFlM?=
 =?utf-8?B?OXcxblk1U0tabnFlN3g0bkxscTlrWldxVTcwT2J0emNOL1VLM2tscW9JL2Fv?=
 =?utf-8?B?OElFeEJsVmM4U3JDSDMweUFWZTljYmJUQUpDVkU5bVIzSWdxVUp4bEtxMmdS?=
 =?utf-8?B?bmJDOWJ1bStiYlZDNUx3bml5VGU0NVZNMkZacTlSNm5zTHkydko2bWpieWQv?=
 =?utf-8?B?anVKbDgzOE5rUWkrUDJOQ2JQVm5PWk5GQXZuZ1g5ODI0d1E5bG5ZQnNqZm9E?=
 =?utf-8?B?L2wwRGdNTVd1cFVDM3JMOXQwbW1kY1VWYUk0Nk8zVlZTbjVQTDk0ZGIwR2dO?=
 =?utf-8?Q?RLogn+8ZTuqQ/TyRoicXvL8k3Urccucy?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2832;6:4EuRkJyAyOiYC800RR7QiGoO5NFL+bTxJP5QB6z8z92KXd00dzDMIAs7uLH+8Lo6A5Ek5mf0+hQKnZ64KfFMjCEj90atx6h3K23AdalZ+nxEzzAlbuvCQVWTkbYgaTUiyRvY7O36y0I5lv5XfJXc6UpOzVH/J4SXCcGIth/ZwqXU0O8oxp9qxF2ht37ivEq7niFca7ceAPIIurqoFI8aKw5OahNESwBK4KcG/+o1bXPThM14AtsZs1SI/p35fkpSknMC3NvstPz9Z/OZ4wiPvZJy/TFFIUa7cR6ipaVtCfId2rNnvHzcyfduRnIkHRybO3M+GnHuiEVuqrCXdunArpiGv0oQTawxXVwAzaULDgk=;5:oEB1rWZGsky//u1QTc4Rbrt/KTLdb2lxVJ8+BIM/TqOQy3x8OD7IaqUwXr2QIuBYdWvufOItbWDvTfQDkMs1m6afnA7ja1B0zBvkCAjv96ggCHNSbrm7aUHzl+8j9BCuM19dY/nEhK+X46WRF01r1/c3zErwIdU8M29DH1up6sU=;24:O5jcuOUwJ/cot13uVIZlGayQOZnfYEOGmx+tPcOxYveR0YinJlpDJK1qMophaBVcJeM/BW1vVkiP+tpqWLCGIHygayzu5LGyv+clkoXdCTI=;7:Hxa5Le8iIABp6Kdz3om8LGFZDXw2IvIW29JPk+WKCEFEI1zaNdagzXU88zY5ZE6SCQ40DR/+9afKCXO0QipOS4zv4TGRzsGOShTlsRH/G3QxCGtM93YAhSmrjj0kOXvcX5hk2/WhaNmlVH8UbCetU/nrqqk5kIs1hgETR6Yh0nmKK3Rhej4EL0kB+OXID8uHZhBHjYt4G1V1Lin0SgSZsPwvfZgGzrsjQMMk40CjuShOjSWe64z95xVlsmJFumL4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2832;20:tvtSxobZtE9v5yqRmgVy3Tx8f1Yjh1cOIpGpNqqacKQPWJxA7qpzpgGqkFd0wcQ+0ZFvSyf14m/0pDSxNTM6GPWjaIuEuZCDFIZip3f4R6LeFiCJ53cNs0eWhZQsYpJdpbX9L7Pl83bH2+nrYyprj6yu/zgZzYyEyFPK2TT/2Mg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 09:59:28.2465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9004479a-60ce-4d2a-05d3-08d57cffa09a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2832
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/26/2018 11:48 AM, tip-bot for Jan Beulich wrote:

>  static void note_page(struct seq_file *m, struct pg_state *st,
> -		      pgprot_t new_prot, int level)
> +		      pgprot_t new_prot, pgprotval_t new_eff, int level)
>  {
> -	pgprotval_t prot, cur;
> +	pgprotval_t prot, cur, eff;
>  	static const char units[] = "BKMGTPE";
>  
>  	/*
> @@ -247,23 +248,24 @@ static void note_page(struct seq_file *m, struct pg_state *st,
>  	 */
>  	prot = pgprot_val(new_prot);
>  	cur = pgprot_val(st->current_prot);
> +	eff = st->effective_prot;
>  
>  	if (!st->level) {
>  		/* First entry */
>  		st->current_prot = new_prot;
> +		st->effective_prot = new_eff;
>  		st->level = level;
>  		st->marker = address_markers;
>  		st->lines = 0;
>  		pt_dump_seq_printf(m, st->to_dmesg, "---[ %s ]---\n",
>  				   st->marker->name);
> -	} else if (prot != cur || level != st->level ||
> +	} else if (prot != cur || new_eff != eff || level != st->level ||
>  		   st->current_address >= st->marker[1].start_address) {
>  		const char *unit = units;
>  		unsigned long delta;
>  		int width = sizeof(unsigned long) * 2;
> -		pgprotval_t pr = pgprot_val(st->current_prot);
>  
> -		if (st->check_wx && (pr & _PAGE_RW) && !(pr & _PAGE_NX)) {
> +		if (st->check_wx && (eff & _PAGE_RW) && !(eff & _PAGE_NX)) {
>  			WARN_ONCE(1,
>  				  "x86/mm: Found insecure W+X mapping at address %p/%pS\n",
>  				  (void *)st->start_address,
> @@ -317,21 +319,30 @@ static void note_page(struct seq_file *m, struct pg_state *st,
>  
>  		st->start_address = st->current_address;
>  		st->current_prot = new_prot;
> +		st->effective_prot = new_eff;
>  		st->level = level;
>  	}
>  }
>  
> -static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr, unsigned long P)
> +static inline pgprotval_t effective_prot(pgprotval_t prot1, pgprotval_t prot2)
> +{
> +	return (prot1 & prot2 & (_PAGE_USER | _PAGE_RW)) |
> +	       ((prot1 | prot2) & _PAGE_NX);
> +}
> +
> +static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
> +			   pgprotval_t eff_in, unsigned long P)
>  {
>  	int i;
>  	pte_t *start;
> -	pgprotval_t prot;
> +	pgprotval_t prot, eff;
>  
>  	start = (pte_t *)pmd_page_vaddr(addr);
>  	for (i = 0; i < PTRS_PER_PTE; i++) {
>  		prot = pte_flags(*start);
> +		eff = effective_prot(eff_in, prot);
>  		st->current_address = normalize_addr(P + i * PTE_LEVEL_MULT);
> -		note_page(m, st, __pgprot(prot), 5);
> +		note_page(m, st, __pgprot(prot), eff, 5);
>  		start++;
>  	}
>  }
> @@ -351,7 +362,7 @@ static inline bool kasan_page_table(struct seq_file *m, struct pg_state *st,
>  	    (pgtable_l5_enabled && __pa(pt) == __pa(kasan_zero_p4d)) ||
>  	    __pa(pt) == __pa(kasan_zero_pud)) {
>  		pgprotval_t prot = pte_flags(kasan_zero_pte[0]);
> -		note_page(m, st, __pgprot(prot), 5);
> +		note_page(m, st, __pgprot(prot), 0, 5);

Isn't this disables W+X check for kasan page table?
Methinks it should be 'prot' here.
