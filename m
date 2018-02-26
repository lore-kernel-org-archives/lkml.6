Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBZAl7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 19:41:59 -0500
Received: from ozlabs.org ([103.22.144.67]:37885 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751904AbeBZAl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 19:41:56 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Feb 2018 11:41:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20180226114147.2ab5c647@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NJbGbTCk46_9_4Ko+KU8SuB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NJbGbTCk46_9_4Ko+KU8SuB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/test_verifier.c

between commit:

  ca36960211eb ("bpf: allow xadd only on aligned memory")

from the bpf tree and commit:

  23d191a82c13 ("bpf: add various jit test cases")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/bpf/test_verifier.c
index 437c0b1c9d21,c987d3a2426f..000000000000
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@@ -11163,64 -11140,95 +11166,153 @@@ static struct bpf_test tests[] =3D=20
  		.result =3D REJECT,
  		.prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
  	},
 +	{
 +		"xadd/w check unaligned stack",
 +		.insns =3D {
 +			BPF_MOV64_IMM(BPF_REG_0, 1),
 +			BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
 +			BPF_STX_XADD(BPF_W, BPF_REG_10, BPF_REG_0, -7),
 +			BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
 +			BPF_EXIT_INSN(),
 +		},
 +		.result =3D REJECT,
 +		.errstr =3D "misaligned stack access off",
 +		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 +	},
 +	{
 +		"xadd/w check unaligned map",
 +		.insns =3D {
 +			BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 +			BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 +			BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 +			BPF_LD_MAP_FD(BPF_REG_1, 0),
 +			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 +				     BPF_FUNC_map_lookup_elem),
 +			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 +			BPF_EXIT_INSN(),
 +			BPF_MOV64_IMM(BPF_REG_1, 1),
 +			BPF_STX_XADD(BPF_W, BPF_REG_0, BPF_REG_1, 3),
 +			BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 3),
 +			BPF_EXIT_INSN(),
 +		},
 +		.fixup_map1 =3D { 3 },
 +		.result =3D REJECT,
 +		.errstr =3D "misaligned value access off",
 +		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 +	},
 +	{
 +		"xadd/w check unaligned pkt",
 +		.insns =3D {
 +			BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
 +				    offsetof(struct xdp_md, data)),
 +			BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
 +				    offsetof(struct xdp_md, data_end)),
 +			BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 +			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
 +			BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 2),
 +			BPF_MOV64_IMM(BPF_REG_0, 99),
 +			BPF_JMP_IMM(BPF_JA, 0, 0, 6),
 +			BPF_MOV64_IMM(BPF_REG_0, 1),
 +			BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
 +			BPF_ST_MEM(BPF_W, BPF_REG_2, 3, 0),
 +			BPF_STX_XADD(BPF_W, BPF_REG_2, BPF_REG_0, 1),
 +			BPF_STX_XADD(BPF_W, BPF_REG_2, BPF_REG_0, 2),
 +			BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 1),
 +			BPF_EXIT_INSN(),
 +		},
 +		.result =3D REJECT,
 +		.errstr =3D "BPF_XADD stores into R2 packet",
 +		.prog_type =3D BPF_PROG_TYPE_XDP,
 +	},
+ 	{
+ 		"jit: lsh, rsh, arsh by 1",
+ 		.insns =3D {
+ 			BPF_MOV64_IMM(BPF_REG_0, 1),
+ 			BPF_MOV64_IMM(BPF_REG_1, 0xff),
+ 			BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 1),
+ 			BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 1),
+ 			BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x3fc, 1),
+ 			BPF_EXIT_INSN(),
+ 			BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 1),
+ 			BPF_ALU32_IMM(BPF_RSH, BPF_REG_1, 1),
+ 			BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0xff, 1),
+ 			BPF_EXIT_INSN(),
+ 			BPF_ALU64_IMM(BPF_ARSH, BPF_REG_1, 1),
+ 			BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x7f, 1),
+ 			BPF_EXIT_INSN(),
+ 			BPF_MOV64_IMM(BPF_REG_0, 2),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.result =3D ACCEPT,
+ 		.retval =3D 2,
+ 	},
+ 	{
+ 		"jit: mov32 for ldimm64, 1",
+ 		.insns =3D {
+ 			BPF_MOV64_IMM(BPF_REG_0, 2),
+ 			BPF_LD_IMM64(BPF_REG_1, 0xfeffffffffffffffULL),
+ 			BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32),
+ 			BPF_LD_IMM64(BPF_REG_2, 0xfeffffffULL),
+ 			BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+ 			BPF_MOV64_IMM(BPF_REG_0, 1),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.result =3D ACCEPT,
+ 		.retval =3D 2,
+ 	},
+ 	{
+ 		"jit: mov32 for ldimm64, 2",
+ 		.insns =3D {
+ 			BPF_MOV64_IMM(BPF_REG_0, 1),
+ 			BPF_LD_IMM64(BPF_REG_1, 0x1ffffffffULL),
+ 			BPF_LD_IMM64(BPF_REG_2, 0xffffffffULL),
+ 			BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+ 			BPF_MOV64_IMM(BPF_REG_0, 2),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.result =3D ACCEPT,
+ 		.retval =3D 2,
+ 	},
+ 	{
+ 		"jit: various mul tests",
+ 		.insns =3D {
+ 			BPF_LD_IMM64(BPF_REG_2, 0xeeff0d413122ULL),
+ 			BPF_LD_IMM64(BPF_REG_0, 0xfefefeULL),
+ 			BPF_LD_IMM64(BPF_REG_1, 0xefefefULL),
+ 			BPF_ALU64_REG(BPF_MUL, BPF_REG_0, BPF_REG_1),
+ 			BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
+ 			BPF_MOV64_IMM(BPF_REG_0, 1),
+ 			BPF_EXIT_INSN(),
+ 			BPF_LD_IMM64(BPF_REG_3, 0xfefefeULL),
+ 			BPF_ALU64_REG(BPF_MUL, BPF_REG_3, BPF_REG_1),
+ 			BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
+ 			BPF_MOV64_IMM(BPF_REG_0, 1),
+ 			BPF_EXIT_INSN(),
+ 			BPF_MOV32_REG(BPF_REG_2, BPF_REG_2),
+ 			BPF_LD_IMM64(BPF_REG_0, 0xfefefeULL),
+ 			BPF_ALU32_REG(BPF_MUL, BPF_REG_0, BPF_REG_1),
+ 			BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
+ 			BPF_MOV64_IMM(BPF_REG_0, 1),
+ 			BPF_EXIT_INSN(),
+ 			BPF_LD_IMM64(BPF_REG_3, 0xfefefeULL),
+ 			BPF_ALU32_REG(BPF_MUL, BPF_REG_3, BPF_REG_1),
+ 			BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
+ 			BPF_MOV64_IMM(BPF_REG_0, 1),
+ 			BPF_EXIT_INSN(),
+ 			BPF_LD_IMM64(BPF_REG_0, 0x952a7bbcULL),
+ 			BPF_LD_IMM64(BPF_REG_1, 0xfefefeULL),
+ 			BPF_LD_IMM64(BPF_REG_2, 0xeeff0d413122ULL),
+ 			BPF_ALU32_REG(BPF_MUL, BPF_REG_2, BPF_REG_1),
+ 			BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_0, 2),
+ 			BPF_MOV64_IMM(BPF_REG_0, 1),
+ 			BPF_EXIT_INSN(),
+ 			BPF_MOV64_IMM(BPF_REG_0, 2),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.result =3D ACCEPT,
+ 		.retval =3D 2,
+ 	},
+=20
  };
 =20
  static int probe_filter_length(const struct bpf_insn *fp)

--Sig_/NJbGbTCk46_9_4Ko+KU8SuB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqTV8sACgkQAVBC80lX
0Gxr0gf+IQlx4HqcMMxfTuakdRa4pBDX2U13K1AC07rSuisndsgR0axRzEjHSUQD
ixR4YIjzQ8X55x1uG+4e2KPY+iBrHTgTGzxJN7/oB9vagsm3zw/rQRoFfGozeALE
qaK2VguJWVL2nAbDOjvuCll0mbPzNG0rvtBhN18c7EksuagcaAq3Mcl3p5PlaA70
nLHGHZ1Y3tHSeGb/VK6Ye8ZqPqPRDLQ/EPiofvIajBmGnTPdRV3jvLQVwg2zKM+g
MRh3eFQJ08hV8bCpPjw1wIJN+fHvKDUVLtc3m98mFxb4mOlYdrWZKWCCIC+af+o+
yXwsyeQByIfwySZx+7wKNMVgH0kWIQ==
=xAZi
-----END PGP SIGNATURE-----

--Sig_/NJbGbTCk46_9_4Ko+KU8SuB--
