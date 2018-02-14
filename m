Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161464AbeBNRk7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:40:59 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34188 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161423AbeBNRky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:40:54 -0500
Date: Wed, 14 Feb 2018 09:40:19 -0800
From: Dave Watson <davejwatson@fb.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: [PATCH v2 11/14] x86/crypto: aesni: Introduce partial block macro
Message-ID: <20180214174019.GA62159@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: CY4PR20CA0015.namprd20.prod.outlook.com (10.173.116.153) To
 BN6PR15MB1746.namprd15.prod.outlook.com (10.174.238.136)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b97d5976-6c54-43f7-3ce7-08d573d20811
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR15MB1746;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1746;3:nV2hY7/jDTsyNvnooWMphc5b9jkZ2lt9Ni2Q9kioYptl6DbxphwDmJkaRx5LTi0yXbvqxpwMxE1DCGuWcjPS1/23vkzZF/VeQJoL767IfX8T8d6S9lpJ9SROSh4ZNbIEz9fKuJDnrKxAkAd1w5vj11Lt88WNGWPWb/0HT7YPlhZdhsT0YTOq7KIugyAGPDCvO4NQLa1ThlUnM414NNZT9pp3RRV+QkKj6BxGeLRbeuLNM9rrMojoGP5NfUkf4x0z;25:70uElRsLvDD/0oHeeGXxktU5tMvv97IA1hPoHrlEW1zg3QS6qr1CDlJLjrk8Ackxp6OmL3/Xvk+mBE4WahTkizXUUxycKmg8BvdBanCaq0v46D/2FasSGjKa7oTecl9r6Cc8gN/hk9UNL2D35fZfycZNfj6o9vgTuA87vjSI76Uha+G3J8thPW3p6BC77e5WJlh+eX7mDgc2dnyrXEcQZnmN89nvT7vfdfPXV7pna28+kjvzdGtPZsONyvrEYV/QnQPLjNFZo8BD3L/qKVZxhz9lxrtN9j49vRTysx7RFKoK3jDLEeg6I+vLRJEqMIbQuPPviifSIhd/MrKA+DHIUg==;31:jYbpaWhXLQBeab1RuOyRRI8+rckmsQ2dYCFmkYQclBP+IjyfI8uwEiMeCEzuPor2iKf06s7c/EnZj+Vq4gUVER4X+l5J8WsexeSjFvyPXqONXg9nN5wKJhARY5yXu4PWiBEMgsT4kXvtFToDSULA9yam/6otG7rA5WG9EJJ1CpSXPhUz6RIDJTaCNhhTMSewXDl26c9TjNiVzQES3Ijy8ohvwVHLLJlDeSxMlBNa52A=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1746:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1746;20:mt6zxDpnhHCNXmaRezxp0ZbU6gExe80owxhq/71nAUaEy4x6WngSx7H06bp9kExWoNi6ycqx9+vlvrSKnjvvlKbmhAL10aJ6Icq5fIcDj5t7iUc3+hskzJijgy47DD84DInTDvfDUvNVK7OC8T36nKqnzpKm9Mi3Y6QpmZm1W0a/kOVpyndEqxsTHjztRsgfEuxcRg62oBYrQCb69b+yOy364AzsVXqpAABZl/bFC5yvO6uyh0sk+mS06U7BRgBi5lfZ5+11fIlod1NK7z3aWM4HNM08vQ3ECXleh+pr98mj9ROsxF1MurE9kgHKqNvBPCrLustc7dHoXqntk3/ludX6Oz78GTE9uR9/d4J8LX6k6elN1+i1SI8GQgoFtR4qN0ikfUqUvSmLfcnIp89+ttEqn6C7FnHhbJbOJrwbK70uTsWvAc1gs5aluyUxmECzZ5tabByJ78RR0nHzdSHdKaFmNrRrWMuQzDbGTHWRB//tMZwlG/hTcK/Jd3MwBfVB;4:+SzqJRZHmQueJUEiKY1lPpOHBD0mg5PsSBPgKiDoJJMyu+wVfX6ABBtFj7+X96khbUIOAp+xGxbxsbDpzWBfQFqe5LIECzcwzjZEcqLrWm5Y5A8B7jcd/fYvLOPSEemQtKSl/7ORCaIgoaxBxBVVwMi5r2jVfbKNsF4UohsTziydZTdZKgEC1Kvq2aVqzQtRZDZWE2f2Ms8O2+2TfCUO0YJHH0lBylTwv8tx1+nRIBYP8Gyhm5SSTuD60qqA/O2cyAvusBN8Ceq4NSY3FYeBanBlZuJS0S4Ix2OwwUf2sPiKuq4bcX2OYldlim/2KTAH5UoScT1mFL3LFywoH1e1P/oY1ygnIJIIRHOa4RjUhXo=
X-Microsoft-Antispam-PRVS: <BN6PR15MB1746916E92360C30F13A2653DDF50@BN6PR15MB1746.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(11241501184)(944501161)(93006095)(93001095)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR15MB1746;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1746;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(33716001)(83506002)(7736002)(6496006)(97736004)(52396003)(52116002)(53936002)(2950100002)(33656002)(54906003)(16586007)(76506005)(110136005)(316002)(6486002)(58126008)(386003)(8936002)(25786009)(81156014)(2906002)(8676002)(23726003)(9686003)(76176011)(478600001)(81166006)(6116002)(105586002)(59450400001)(7416002)(6666003)(68736007)(106356001)(50466002)(4326008)(305945005)(16526019)(47776003)(1076002)(86362001)(186003)(5660300001)(33896004)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1746;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1746;23:1Q/2AjPzfumvS+i7X6CzHITDErFhrUN/z0onmh0oz?=
 =?us-ascii?Q?Ssmv8bA2DGqEdye5uW7RG5yi9aD0nLg0yq1MujPXSzqxtDep8hNGWFbj2Fa/?=
 =?us-ascii?Q?M3mWgqx9POp0eftFyX8ibcE9aBHeDOOKb7V9j3OK+sSGsuBW4uwvqH82h0f1?=
 =?us-ascii?Q?JDek8Z2LyqJbDr/sut4b7NRI0m3hDMrFHM1KKQPFpxXMXCEixX3Mq8aKv62S?=
 =?us-ascii?Q?vofc+qktmjsUbeayBr5wU0SJnSYgvjNwBSpl+SIrM2OxaIOR3pf0mmw+YdlE?=
 =?us-ascii?Q?hhBlFlGgdPZgmggWNh+YvPFLXCtdNdalheVncU04JhAwFBB+lPptIbPb5GaZ?=
 =?us-ascii?Q?NF5N4OMaOwDh5D1b8NphlNZb31nE8ec+xga1qv+V4mzYPBc5a2rD8Q5SGmUt?=
 =?us-ascii?Q?oO4yoWfBAQuZSl7ScpwAu84IPE+vDQnnUCUbdCTe/Jx34ZovxV8GWxzchQhc?=
 =?us-ascii?Q?judDlxr8O6LwO1lozRD66yPP71pHG+cNZSi1QzvrF5zuPge8EKaL10cn8NIS?=
 =?us-ascii?Q?UqEkJ52j8PwKRZj6/UyISJdC4NjOkghipMb0Cg61upKLeE/qGbJ7t0i4l8c3?=
 =?us-ascii?Q?VGKfwz+KjubTWf1wFmVsXFYE8LqLvdE0etWi22Trhyuj50u73QI614WvYO4f?=
 =?us-ascii?Q?lYD8cSfMs42M3j1ZSRd/GelJ2xvGOFgaJ48G9SPQb0xgRXoVFhr/ct0St/sT?=
 =?us-ascii?Q?gEvUECMVFxtd0OUxBiEYIRgIcu0aDclHdvoALOcwhRAl+UnuGZOPVf1V03Y+?=
 =?us-ascii?Q?jSaRRcCIdagNx9tNiyZ8GyGQOT8I4a11LUCaJwldlWplyePXWLWxV6laSK73?=
 =?us-ascii?Q?ileYThr8dQxNAEiO9gDmf+6FtPxezJB5X1F4aAI+++Z3IUQbc0rSJqKAMyOc?=
 =?us-ascii?Q?w55onjaRb7x5GwASCw6nGIhc+wvPD0/btGtBK2IZW9QWpY82E4ZwQy2zZ1yM?=
 =?us-ascii?Q?ogoF9Hvn7QBETa2vhxknAvN6ugElm1gjzH2IKsASKecm4zi15yWw5KnD5Lfz?=
 =?us-ascii?Q?VBTItFs5DIlsgR8CvEgmwH0+WnyG5YqYP1mG+onZ3l9RvxbxoflQr1cCIqt4?=
 =?us-ascii?Q?Krv7PrG6iGCL3CDjwtZSLH62axiX46sjxdhAHiYtHt4UfiEAtcN30fN84Z76?=
 =?us-ascii?Q?IBT0nk5bWJr8HBJtN7OLbcCKje2knh9GjBz4s2gtkuoo8EdgCKDW1PQnqNTX?=
 =?us-ascii?Q?eo4JXQUbz5zRouQyaWVPGTK1T5CcsNek01L7497x4W+/slIMNV4Dmvj9bwUS?=
 =?us-ascii?Q?eTiyV93I1Xg4MwuPEwIpBZIQankQ1Cuzw2V8tiqQSzT8EX3SR9KAVmIMGfLL?=
 =?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1746;6:9b/M3OZXZXEQs1JvqCL3asOk0Hrdd4TthWqZWR5sx2mkw5Rv/qtQ/g6X8xYqGVxwN4rcm6dp9HmNpZmlmZeqFPNXhVyYsnNFIwIvuhWA6OjNNzkLLuKVYnQNYKBr/XphkHnLr9n8/vwynbSW2Ny8KUSdd4S0mNXhMDB+4sxBt0B5r/LtBGbtG/kdPqnLpVWp5pirnQFrOaXjAtcLlgR3Bd4Usc+C5qxBBQt6trjZCY8PWcAP3J0cPcCYEpUNA6Uttd7tUz/UheLyMmXUrDDW1EB3KZ3uVGk6HXtuKQ/78+JuUWaDxslGQt0vfYeTZAYblp6Dw8Mm1/30Tp9eesud9SAQ+lSLGAvcImH49aLQlxc=;5:rBTLxn4rHIT3ZDvIz2SAVwBpRr35PttlcIOm//v7QbKd/HP+3j8ge+YYn2WL5nlTH6YkGJIxhk5nA1SrumggnjcXACt6WfK+mYm8AX72zTe+3k+FWsaoFyiGcPg9QNbPXyM4irc9YVOrlyx/mHBJgTas133GTU+85TodTk66eQ4=;24:2Hhy3gHLxX0L9I7feHLw4BJ8eeam6vWaxtlCPxUpbcQNrCxS55kvFITDc2mE9PO6/LE9wG83JCht1wmYCIIR32e6GpNj48goQBCjh9f3U9c=;7:ZCPChwyR+jximb9e/UAYdCYVPCLZAzXYYIse0OIWIBsEFLwWtoxoVzkviV5FEikBrVHWLuG5/QVX/4TiYByFAXu5lkdAQuLWLLrynbGJrWTGYeTUe0DXmyaB5TOefmMtObs5uA2Rxm4y1FZv9YihrscdhuLY4Cux3Eflhv4KpXQW5HBtbTkmiSjr0pftsVJGAPl11ey0etMfYA4SD5tt1bhFZn9YO3N277ZwXhGgZzLTPq4aKNtqPpzJt/WttwUz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1746;20:xmh1NiqlJPb3T7zAuyhZ4ymU+t7gsmVzFQjIfG0D9iOo4fsnlVDZX3do+Gz22GmCnY8E6Tjrv9yU1PJXDsOdLOVznjzPoQ16sFINm9fEmR8/I9loZzOvMz+u249SpMWZF5cFiRhlUQDqbTpxSVdAYkP6s+I013wG1Yy2XWqZDhA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:40:25.6123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97d5976-6c54-43f7-3ce7-08d573d20811
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1746
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this diff, multiple calls to GCM_ENC_DEC will
succeed, but only if all calls are a multiple of 16 bytes.

Handle partial blocks at the start of GCM_ENC_DEC, and update
aadhash as appropriate.

The data offset %r11 is also updated after the partial block.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 151 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 3ada06b..398bd2237f 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -284,7 +284,13 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	movdqu AadHash(%arg2), %xmm8
 	movdqu HashKey(%arg2), %xmm13
 	add %arg5, InLen(%arg2)
+
+	xor %r11, %r11 # initialise the data pointer offset as zero
+	PARTIAL_BLOCK %arg3 %arg4 %arg5 %r11 %xmm8 \operation
+
+	sub %r11, %arg5		# sub partial block data used
 	mov %arg5, %r13		# save the number of bytes
+
 	and $-16, %r13		# %r13 = %r13 - (%r13 mod 16)
 	mov %r13, %r12
 	# Encrypt/Decrypt first few blocks
@@ -605,6 +611,150 @@ _get_AAD_done\@:
 	movdqu \TMP6, AadHash(%arg2)
 .endm
 
+# PARTIAL_BLOCK: Handles encryption/decryption and the tag partial blocks
+# between update calls.
+# Requires the input data be at least 1 byte long due to READ_PARTIAL_BLOCK
+# Outputs encrypted bytes, and updates hash and partial info in gcm_data_context
+# Clobbers rax, r10, r12, r13, xmm0-6, xmm9-13
+.macro PARTIAL_BLOCK CYPH_PLAIN_OUT PLAIN_CYPH_IN PLAIN_CYPH_LEN DATA_OFFSET \
+	AAD_HASH operation
+	mov 	PBlockLen(%arg2), %r13
+	cmp	$0, %r13
+	je	_partial_block_done_\@	# Leave Macro if no partial blocks
+	# Read in input data without over reading
+	cmp	$16, \PLAIN_CYPH_LEN
+	jl	_fewer_than_16_bytes_\@
+	movups	(\PLAIN_CYPH_IN), %xmm1	# If more than 16 bytes, just fill xmm
+	jmp	_data_read_\@
+
+_fewer_than_16_bytes_\@:
+	lea	(\PLAIN_CYPH_IN, \DATA_OFFSET, 1), %r10
+	mov	\PLAIN_CYPH_LEN, %r12
+	READ_PARTIAL_BLOCK %r10 %r12 %xmm0 %xmm1
+
+	mov PBlockLen(%arg2), %r13
+
+_data_read_\@:				# Finished reading in data
+
+	movdqu	PBlockEncKey(%arg2), %xmm9
+	movdqu	HashKey(%arg2), %xmm13
+
+	lea	SHIFT_MASK(%rip), %r12
+
+	# adjust the shuffle mask pointer to be able to shift r13 bytes
+	# r16-r13 is the number of bytes in plaintext mod 16)
+	add	%r13, %r12
+	movdqu	(%r12), %xmm2		# get the appropriate shuffle mask
+	PSHUFB_XMM %xmm2, %xmm9		# shift right r13 bytes
+
+.ifc \operation, dec
+	movdqa	%xmm1, %xmm3
+	pxor	%xmm1, %xmm9		# Cyphertext XOR E(K, Yn)
+
+	mov	\PLAIN_CYPH_LEN, %r10
+	add	%r13, %r10
+	# Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
+	sub	$16, %r10
+	# Determine if if partial block is not being filled and
+	# shift mask accordingly
+	jge	_no_extra_mask_1_\@
+	sub	%r10, %r12
+_no_extra_mask_1_\@:
+
+	movdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
+	# get the appropriate mask to mask out bottom r13 bytes of xmm9
+	pand	%xmm1, %xmm9		# mask out bottom r13 bytes of xmm9
+
+	pand	%xmm1, %xmm3
+	movdqa	SHUF_MASK(%rip), %xmm10
+	PSHUFB_XMM	%xmm10, %xmm3
+	PSHUFB_XMM	%xmm2, %xmm3
+	pxor	%xmm3, \AAD_HASH
+
+	cmp	$0, %r10
+	jl	_partial_incomplete_1_\@
+
+	# GHASH computation for the last <16 Byte block
+	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
+	xor	%rax,%rax
+
+	mov	%rax, PBlockLen(%arg2)
+	jmp	_dec_done_\@
+_partial_incomplete_1_\@:
+	add	\PLAIN_CYPH_LEN, PBlockLen(%arg2)
+_dec_done_\@:
+	movdqu	\AAD_HASH, AadHash(%arg2)
+.else
+	pxor	%xmm1, %xmm9			# Plaintext XOR E(K, Yn)
+
+	mov	\PLAIN_CYPH_LEN, %r10
+	add	%r13, %r10
+	# Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
+	sub	$16, %r10
+	# Determine if if partial block is not being filled and
+	# shift mask accordingly
+	jge	_no_extra_mask_2_\@
+	sub	%r10, %r12
+_no_extra_mask_2_\@:
+
+	movdqu	ALL_F-SHIFT_MASK(%r12), %xmm1
+	# get the appropriate mask to mask out bottom r13 bytes of xmm9
+	pand	%xmm1, %xmm9
+
+	movdqa	SHUF_MASK(%rip), %xmm1
+	PSHUFB_XMM %xmm1, %xmm9
+	PSHUFB_XMM %xmm2, %xmm9
+	pxor	%xmm9, \AAD_HASH
+
+	cmp	$0, %r10
+	jl	_partial_incomplete_2_\@
+
+	# GHASH computation for the last <16 Byte block
+	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
+	xor	%rax,%rax
+
+	mov	%rax, PBlockLen(%arg2)
+	jmp	_encode_done_\@
+_partial_incomplete_2_\@:
+	add	\PLAIN_CYPH_LEN, PBlockLen(%arg2)
+_encode_done_\@:
+	movdqu	\AAD_HASH, AadHash(%arg2)
+
+	movdqa	SHUF_MASK(%rip), %xmm10
+	# shuffle xmm9 back to output as ciphertext
+	PSHUFB_XMM	%xmm10, %xmm9
+	PSHUFB_XMM	%xmm2, %xmm9
+.endif
+	# output encrypted Bytes
+	cmp	$0, %r10
+	jl	_partial_fill_\@
+	mov	%r13, %r12
+	mov	$16, %r13
+	# Set r13 to be the number of bytes to write out
+	sub	%r12, %r13
+	jmp	_count_set_\@
+_partial_fill_\@:
+	mov	\PLAIN_CYPH_LEN, %r13
+_count_set_\@:
+	movdqa	%xmm9, %xmm0
+	MOVQ_R64_XMM	%xmm0, %rax
+	cmp	$8, %r13
+	jle	_less_than_8_bytes_left_\@
+
+	mov	%rax, (\CYPH_PLAIN_OUT, \DATA_OFFSET, 1)
+	add	$8, \DATA_OFFSET
+	psrldq	$8, %xmm0
+	MOVQ_R64_XMM	%xmm0, %rax
+	sub	$8, %r13
+_less_than_8_bytes_left_\@:
+	movb	%al, (\CYPH_PLAIN_OUT, \DATA_OFFSET, 1)
+	add	$1, \DATA_OFFSET
+	shr	$8, %rax
+	sub	$1, %r13
+	jne	_less_than_8_bytes_left_\@
+_partial_block_done_\@:
+.endm # PARTIAL_BLOCK
+
 /*
 * if a = number of total plaintext bytes
 * b = floor(a/16)
@@ -623,7 +773,6 @@ _get_AAD_done\@:
 
 	movdqu AadHash(%arg2), %xmm\i		    # XMM0 = Y0
 
-	xor	   %r11, %r11 # initialise the data pointer offset as zero
 	# start AES for num_initial_blocks blocks
 
 	movdqu CurCount(%arg2), \XMM0                # XMM0 = Y0
-- 
2.9.5
