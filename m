Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2252b90H5OdwQmL353nZoenE007+P+zYW2KBobobwrhXfIYxQZ4MT9HNp2J4ll2PhBFq5wjg
ARC-Seal: i=1; a=rsa-sha256; t=1517590832; cv=none;
        d=google.com; s=arc-20160816;
        b=tthjOI7oGhL9vspfdE6pX6+mauZjH0g/7D7lnRWN9RqP9IjvzBoHceYz5mzgeifMSO
         y6wTVWzbEGoE989AQVM0jB/sclcsu+Gdf7eTJKNeuQ/eNflvpdcpYhrbCyIjli3Xky6q
         TDul0Qelw+BNJSgIkIKCfZ7tGwnMXqxVSzCnpXJYamHmA5iDvisXaE89PvU66zUAOfuN
         bqS20qtT5QEC9MyxbDarZBHxw5QU3ixVggXabngM8PXzRN1pub+FhCCnenff21hs04CL
         D2eb3O+HWQQV8jM8k0cS4GEfONRX0Sf7MFXL5FNpLT0Ydxrih4rgRAOmkrOSZTd7kCkt
         v46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pd5dmbQ8cGKPTpJQGpI/EmcL3KzEuryf72EyrnD/z1c=;
        b=zljc03AAPMlx/QDMDbomiGbWO/OnLN6BdFqkqk5ZctGY40Ka69gZVc+zJ+EQvSsg5D
         O85DP0nS4t9i3fBgwIe03uhlZzpoZkU+UoBKmtVY2acUQds/hNf5Xqn2RtFd6wFdg4P7
         ZDfxVKOlyfbocfKTPLP7icCA+ppi+8W8Mc7lNqrs6wioJtmE0u+vjTb5Y+kppYcgMBpz
         vjOjO0KK1KlAVmGfdbZEE5Td0lhqGpsQly/KpQRVeDWyusxZksJx3V+y8eVLG9uwXA7e
         G2sB3/FefKV5FKFMOm+86s+RhnZ59IyTDsMG49w9Wh4WsynRq6DLhbcO9PobjRJzeytl
         lCAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.4 07/67] bpf: avoid false sharing of map refcount with max_entries
Date: Fri,  2 Feb 2018 17:57:36 +0100
Message-Id: <20180202140816.064013359@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309325449404052?=
X-GMAIL-MSGID: =?utf-8?q?1591309325449404052?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ upstream commit be95a845cc4402272994ce290e3ad928aff06cb9 ]

In addition to commit b2157399cc98 ("bpf: prevent out-of-bounds
speculation") also change the layout of struct bpf_map such that
false sharing of fast-path members like max_entries is avoided
when the maps reference counter is altered. Therefore enforce
them to be placed into separate cachelines.

pahole dump after change:

  struct bpf_map {
        const struct bpf_map_ops  * ops;                 /*     0     8 */
        struct bpf_map *           inner_map_meta;       /*     8     8 */
        void *                     security;             /*    16     8 */
        enum bpf_map_type          map_type;             /*    24     4 */
        u32                        key_size;             /*    28     4 */
        u32                        value_size;           /*    32     4 */
        u32                        max_entries;          /*    36     4 */
        u32                        map_flags;            /*    40     4 */
        u32                        pages;                /*    44     4 */
        u32                        id;                   /*    48     4 */
        int                        numa_node;            /*    52     4 */
        bool                       unpriv_array;         /*    56     1 */

        /* XXX 7 bytes hole, try to pack */

        /* --- cacheline 1 boundary (64 bytes) --- */
        struct user_struct *       user;                 /*    64     8 */
        atomic_t                   refcnt;               /*    72     4 */
        atomic_t                   usercnt;              /*    76     4 */
        struct work_struct         work;                 /*    80    32 */
        char                       name[16];             /*   112    16 */
        /* --- cacheline 2 boundary (128 bytes) --- */

        /* size: 128, cachelines: 2, members: 17 */
        /* sum members: 121, holes: 1, sum holes: 7 */
  };

Now all entries in the first cacheline are read only throughout
the life time of the map, set up once during map creation. Overall
struct size and number of cachelines doesn't change from the
reordering. struct bpf_map is usually first member and embedded
in map structs in specific map implementations, so also avoid those
members to sit at the end where it could potentially share the
cacheline with first map values e.g. in the array since remote
CPUs could trigger map updates just as well for those (easily
dirtying members like max_entries intentionally as well) while
having subsequent values in cache.

Quoting from Google's Project Zero blog [1]:

  Additionally, at least on the Intel machine on which this was
  tested, bouncing modified cache lines between cores is slow,
  apparently because the MESI protocol is used for cache coherence
  [8]. Changing the reference counter of an eBPF array on one
  physical CPU core causes the cache line containing the reference
  counter to be bounced over to that CPU core, making reads of the
  reference counter on all other CPU cores slow until the changed
  reference counter has been written back to memory. Because the
  length and the reference counter of an eBPF array are stored in
  the same cache line, this also means that changing the reference
  counter on one physical CPU core causes reads of the eBPF array's
  length to be slow on other physical CPU cores (intentional false
  sharing).

While this doesn't 'control' the out-of-bounds speculation through
masking the index as in commit b2157399cc98, triggering a manipulation
of the map's reference counter is really trivial, so lets not allow
to easily affect max_entries from it.

Splitting to separate cachelines also generally makes sense from
a performance perspective anyway in that fast-path won't have a
cache miss if the map gets pinned, reused in other progs, etc out
of control path, thus also avoids unintentional false sharing.

  [1] https://googleprojectzero.blogspot.ch/2018/01/reading-privileged-memory-with-side.html

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/bpf.h |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -31,17 +31,25 @@ struct bpf_map_ops {
 };
 
 struct bpf_map {
-	atomic_t refcnt;
+	/* 1st cacheline with read-mostly members of which some
+	 * are also accessed in fast-path (e.g. ops, max_entries).
+	 */
+	const struct bpf_map_ops *ops ____cacheline_aligned;
 	enum bpf_map_type map_type;
 	u32 key_size;
 	u32 value_size;
 	u32 max_entries;
 	u32 pages;
 	bool unpriv_array;
-	struct user_struct *user;
-	const struct bpf_map_ops *ops;
-	struct work_struct work;
+	/* 7 bytes hole */
+
+	/* 2nd cacheline with misc members to avoid false sharing
+	 * particularly with refcounting.
+	 */
+	struct user_struct *user ____cacheline_aligned;
+	atomic_t refcnt;
 	atomic_t usercnt;
+	struct work_struct work;
 };
 
 struct bpf_map_type_list {
