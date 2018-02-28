Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935337AbeB1WX1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:23:27 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34438 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935151AbeB1WXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:23:25 -0500
X-Google-Smtp-Source: AG47ELuUgYX5xkjIJmMFiQuZlZbzx12wNCsBfziTiq4Sh0HytPRfsDbn6ZUkX82NgW2xzfHDUALtSg==
Date: Wed, 28 Feb 2018 12:23:20 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kvm/mmu: const-ify struct kvm_memory_slot pointers
Message-ID: <20180228222320.23xpoldpmhcp26vi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zma6suokuyszoxu2"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zma6suokuyszoxu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Remove `(struct kvm_memory_slot *)` cast of the
`const struct kvm_memory_slot *memslot` parameter and
const-ify all references to that pointer down the
function call chain.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index f551962ac29488431b..e6b32de4d7426fecb3 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1235,7 +1235,7 @@ static void pte_list_remove(u64 *spte, struct kvm_rma=
p_head *rmap_head)
 }
=20
 static struct kvm_rmap_head *__gfn_to_rmap(gfn_t gfn, int level,
-					   struct kvm_memory_slot *slot)
+					   const struct kvm_memory_slot *slot)
 {
 	unsigned long idx;
=20
@@ -1678,7 +1678,7 @@ static int kvm_set_pte_rmapp(struct kvm *kvm, struct =
kvm_rmap_head *rmap_head,
=20
 struct slot_rmap_walk_iterator {
 	/* input fields. */
-	struct kvm_memory_slot *slot;
+	const struct kvm_memory_slot *slot;
 	gfn_t start_gfn;
 	gfn_t end_gfn;
 	int start_level;
@@ -1705,7 +1705,7 @@ rmap_walk_init_level(struct slot_rmap_walk_iterator *=
iterator, int level)
=20
 static void
 slot_rmap_walk_init(struct slot_rmap_walk_iterator *iterator,
-		    struct kvm_memory_slot *slot, int start_level,
+		    const struct kvm_memory_slot *slot, int start_level,
 		    int end_level, gfn_t start_gfn, gfn_t end_gfn)
 {
 	iterator->slot =3D slot;
@@ -5081,7 +5081,7 @@ typedef bool (*slot_level_handler) (struct kvm *kvm, =
struct kvm_rmap_head *rmap_
=20
 /* The caller should hold mmu-lock before calling this function. */
 static __always_inline bool
-slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
+slot_handle_level_range(struct kvm *kvm, const struct kvm_memory_slot *mem=
slot,
 			slot_level_handler fn, int start_level, int end_level,
 			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb)
 {
@@ -5111,7 +5111,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_m=
emory_slot *memslot,
 }
=20
 static __always_inline bool
-slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
+slot_handle_level(struct kvm *kvm, const struct kvm_memory_slot *memslot,
 		  slot_level_handler fn, int start_level, int end_level,
 		  bool lock_flush_tlb)
 {
@@ -5138,7 +5138,7 @@ slot_handle_large_level(struct kvm *kvm, struct kvm_m=
emory_slot *memslot,
 }
=20
 static __always_inline bool
-slot_handle_leaf(struct kvm *kvm, struct kvm_memory_slot *memslot,
+slot_handle_leaf(struct kvm *kvm, const struct kvm_memory_slot *memslot,
 		 slot_level_handler fn, bool lock_flush_tlb)
 {
 	return slot_handle_level(kvm, memslot, fn, PT_PAGE_TABLE_LEVEL,
@@ -5245,10 +5245,8 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm =
*kvm,
 void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 				   const struct kvm_memory_slot *memslot)
 {
-	/* FIXME: const-ify all uses of struct kvm_memory_slot.  */
 	spin_lock(&kvm->mmu_lock);
-	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
-			 kvm_mmu_zap_collapsible_spte, true);
+	slot_handle_leaf(kvm, memslot, kvm_mmu_zap_collapsible_spte, true);
 	spin_unlock(&kvm->mmu_lock);
 }
=20
--=20
2.16.2

--zma6suokuyszoxu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqXK9gACgkQruvLfWhy
VBk2ZRAAvpfTkox2wnkOyI+Ig4AlNy9i9OuEvgwa8uLxeGlNK6U7zVClogon0ivD
xiowUOQW32GEohAXKWsECgsAgA1RPkW+gKoIlpxBLFQKXdZN244UseXH2gqM6PDt
W9kTOBR4gdtogo7/cwOHeyBUI1kvMy5rjmlg9ItJTUu02dBTJ84TLZkulnagARol
4Z9VBngc1odXQVbVxxnYa2dyM0EicVhWnyVZhL81de3rLCkuKGDxxpcgzgkG6zQU
UTrN1BpI1Rxuy8yokk9lux20udjycgK82VN6nruViVas1KtDz7rwfcH5aBE00B6y
uf0wEqCEHZmNmONWOFgc7P/U2yvN0joYkHuXIvByCFhVtxRrPATLQ2/VFJI4kCUC
NcM9i+4Xh73baS0Zs/DMRHfWoOSe6t0r7InFRa8CJYIRvli9384jWB4ZOl+RsgeQ
VWn8/ytO7sKY+33mEoCsSXzzU22wLQhKpXHlXV31qi/RM3QWf+xLXFssqfsAbQg4
4C0PcMAcSTLUv2Ii9p3FGKg1HlNtzX38c8zdRPAa+UW+HuQ2lTs5YTIJPx/VjWed
1J0RZf81VLHcQpFFgIQ4sBD5KlDktqmWIPgd0mR0m8hvQmCYJjUM7YkkRWyIeKYe
CTx/hVaz8DnrcGrUuGVSp2hb4d8FisN/0EgomohPTmkpqzyLG+k=
=p/nH
-----END PGP SIGNATURE-----

--zma6suokuyszoxu2--
