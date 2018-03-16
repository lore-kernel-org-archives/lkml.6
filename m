Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtKpcgHX1GUA4PoQHJrAgDI9Dt46pT3FDNRt97YcwvsbVoTxMlNdoCv+GldHECSH7m5B9/t
ARC-Seal: i=1; a=rsa-sha256; t=1521214813; cv=none;
        d=google.com; s=arc-20160816;
        b=bfJ9wmMsHMXasRqBMH07PsTb173aJmRESPZ4i2NB81KjDFro/PYJrD3xjNWwmLCYOO
         4yj3lASVRGAoYEQDlJHlnH0nS3Z8iAVXG/FWrVOwe3/n5+mYGs+S5b0lpv97uICkAmF4
         v6nrzR7U//rFyBacR0CLOblcddKInua4N4j5XIlvOq4XiOfMVrPWekTfssyzrQbMHiQK
         hdNBTd+7IT7eIW8Pf7C17yD+he0jsIDNFo6owSMz44rs4P55g/RqWvrXWiNPNiZhWLum
         MIBytDT771WkfGU0hLxMEoDtsLK1VGdAb/LO3/yjxnkKiyJld7+Si/dOaDuyp+XlpcFs
         dM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/gcu4Gol5ZerFI+aVbFAoMNyazz+ifLzPhnQ/DuSDM4=;
        b=yKoVg7Z1hVJ7MiKVPNkvEdlI6T66TLYKOW6mfdELaRrKkU+kQGiuBjP5UEAiIEeW9X
         9rKIKSNw7oTURV35hB5jyPpuGQnUji7BF0P7PeReGEDPwq85HYUjCSwlMii4qnyXXOL1
         C6qvR/xUOiEbRAvwxXcKTAzEf5t4UE/Hb3LXZRlb5aox6e/QJ2M+IpzNnzR93BHx4b54
         g0oot2UVQspjt4UdnAcliUH08CRi2B+MoULcuKGn4wPRhkRgfb/X6Uchuh1ZpMxgSjm4
         3zivl7Z++P4b9SEm8tU6HFrepcH0Q0shpEo8qtl/54lbCEPv7j9Vbrx8NENgupuWKk+j
         PI2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 4.15 027/128] gfs2: Fixes to "Implement iomap for block_map" (2)
Date: Fri, 16 Mar 2018 16:22:48 +0100
Message-Id: <20180316152337.877284662@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109343746769374?=
X-GMAIL-MSGID: =?utf-8?q?1595109343746769374?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 3b5da96e4585a2788da6a07619bda3518d76eb30 upstream.

It turns out that commit 3229c18c0d6b2 'Fixes to "Implement iomap for
block_map"' introduced another bug in gfs2_iomap_begin that can cause
gfs2_block_map to set bh->b_size of an actual buffer to 0.  This can
lead to arbitrary incorrect behavior including crashes or disk
corruption.  Revert the incorrect part of that commit.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/bmap.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -811,9 +811,6 @@ do_alloc:
 			iomap->length = hole_size(inode, lblock, &mp);
 		else
 			iomap->length = size - pos;
-	} else {
-		if (height <= ip->i_height)
-			iomap->length = hole_size(inode, lblock, &mp);
 	}
 	goto out_release;
 }
